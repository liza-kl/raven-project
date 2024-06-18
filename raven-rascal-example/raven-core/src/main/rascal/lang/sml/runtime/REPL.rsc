module lang::sml::runtime::REPL

import lang::sml::runtime::Command;
import lang::sml::runtime::Model;
import lang::sml::model::Model;
import lang::sml::model::REPL;
import lang::sml::model::Command;
import lang::raven::Environment; 
import lang::sml::runtime::RuntimeCallbacks;
import lang::sml::runtime::RuntimeRenderer;
import IO;
import lang::Main;
import Map;
import Set;

public Env eval(Env env, Command cmd: MachInstCreate(UUID miid, UUID mid)) {
  Model mi = machInst(miid, mid, -1, ());
  env = env_store(env, miid, mi);
  //post migrate
  Model m = getMach(env, mid);
  env = eval(env, MachAddMachInst(mid, miid));
  for(UUID sid <- m.states) {
    //Model s = getState(env, sid);
    <env, siid> = env_getNextId(env);
    env = eval(env, StateInstCreate(siid, sid, miid));
    env = eval(env, MachInstAddStateInst(miid, sid, siid));
    env = eval(env, MachInstInitialize(miid));
  }
  return env;
}

public Env eval(Env env, Command cmd: MachInstDelete(UUID miid, UUID mid)) {
  //pre migrate
  Model mi = getMachInst(env, miid);
  Model m = getMach(env, mi.mid);
  for(UUID sid <- m.states) {
    //Model s = getState(env, sid);
    UUID siid = mi.sis[sid];
    env = eval(env, MachInstRemoveStateInst(miid, sid, siid));
    env = eval(env, StateInstCreate(siid, sid, miid));
  }
  //actual deletion
  env = env_delete(env, miid);
  return env;
}

public Env eval(Env env, Command cmd: MachInstAddStateInst(UUID miid, UUID sid, UUID siid)) {
  env = visit(env) {
    case machInst( miid,  mid,  cur, sis)
      => machInst(miid, mid, cur, sis + (sid : siid))
  }
  return env;
}

public Env eval(Env env, Command cmd: MachInstRemoveStateInst(UUID miid, UUID sid, UUID siid)) {
  //pre-migrate
  Model mi = getMachInst(env, miid);
  if(mi.cur == siid) {
    env = eval(env, MachInstSetCurState(miid, -1));
  }
  //remove the state instance
  env = visit(env) {
    case machInst( miid,  mid,  cur,sis) =>
      machInst(miid, mid, cur, delete(sis, sid))
  }
  return env;
}

public Env eval(Env env, Command cmd: MachInstInitialize(UUID miid)) {
  Model mi = getMachInst(env, miid);
  if(size(mi.sis) > 0 && mi.cur == -1) {
    UUID sid = min(domain(mi.sis));
    UUID siid = mi.sis[sid];
    env = eval(env, MachInstSetCurState(miid, siid));      
  }
  return env;
}


public Env eval(Env env, Command cmd: MachInstSetCurState(UUID miid, UUID siid)) {
  env = visit(env) {
    case machInst(miid, mid, _, sis) => machInst(miid, mid, siid, sis)
  }
  //post migrate
  if(siid != -1) {
    Model si = getStateInst(env, siid);
    env = eval(env, StateInstSetCount(siid, si.count+1));
  }
  return env;
}

public Env eval(Env env, Command cmd: StateInstCreate(UUID siid, UUID sid, UUID miid)) {
  Model si = stateInst(siid, sid, 0);
  env = env_store(env, siid, si);
  //post migrate
  env = eval(env, MachInstAddStateInst(miid, sid, siid));
  return env;
}

public Env eval(Env env, Command cmd: StateInstSetCount(UUID siid, int count)) {
  env = visit(env){
    case stateInst(siid,  sid, _) => stateInst(siid, sid, count)
  }
  return env;
}

public Env eval(Env env, Command cmd: StateInstDelete(UUID siid, UUID miid)) {
  Model si = getStateInst(env, siid);
  env = env_delete(env, siid);
  return env;
}

public Env eval(Env env, Command cmd: MachInstTrigger(UUID miid, ID trigger)) {
  Model mi = getMachInst(env, miid);
  Model si = getStateInst(env, mi.cur);
  Model s = getState(env, si.sid);
  if(mi.cur == -1){
    env = eval(env, MachInstMissingCurState(miid));
    return env;
  }
  for(UUID tid <- s.to) {
    Model t = getTrans(env, tid);
    if(trigger == t.trigger) {
      UUID tgtSiId = mi.sis[t.tgt];
      env = eval(env, MachInstSetCurState(miid, tgtSiId));
      return env;
    }
  }
  // TODO: missing case!
  // Add explicit hisotry 
 // env = eval(env, MachInstQuiescence(miid));
  return env;
}


public default Env eval(Env env, Command cmd) {
  throw "Missing eval case";
}