module lang::sml::model::REPL

import lang::raven::Environment; 

import lang::sml::model::Model;
import lang::sml::model::Command;

import lang::sml::runtime::Model;
import lang::sml::runtime::Command;
import lang::sml::runtime::REPL;

//import lang::sml::model::Renderer;
//import lang::raven::helpers::Server;
//import Main;
//import Interpreter::RavenNode;
//import lang::sml::control::ViewCommand;
//import ApplicationConf;
//import IO;
//import Map;


// How
//This is a REPL interpreter for SML.
//todo: add interpreter for machine instances (running machines)

//UUID UUID_NONE = 0;  //an element has no id
//ID ID_NONE = "";     //an element has no name (yet)
public /*effect*/ Env eval(Env env, Command cmd: MachCreate(UUID mid)) {
  Model m = mach(mid, "", [], []);
  env[mid] = m;
  return env;
}

public /*inverse effect*/ Env eval(Env env, Command cmd: MachDelete(UUID mid)) {
  //pre-migrate
  Model m = getMach(env, mid);
  for(UUID sid <- m.states) {
    env = eval(env, StateDelete(sid));
  }

  for(UUID miid <- m.instances) {
    env = eval(env, MachInstDelete(miid, mid));
  }

  //delete machine
  env = env_delete(env, mid);
  return env;
}

public /*side-effect*/ Env eval(Env env, Command cmd: MachAddState(UUID mid, UUID sid)) {
  env = visit(env) {
    case mach(UUID mid, ID name, list[UUID] states, list[UUID] instances) =>
      mach(mid, name, states + [sid], instances)
  }

  //post-migrate
  Model m = getMach(env, mid); 
  for(UUID miid <- m.instances) {
    <env, siid> = env_getNextId(env);
    env = eval(env, StateInstCreate(siid, sid, miid));
    env = eval(env, MachInstAddStateInst(miid, sid, siid));
    env = eval(env, MachInstInitialize(miid));
  }

  return env;
}

public /*inverse side-effect*/ Env eval(Env env, Command cmd: MachRemoveState(UUID mid, UUID sid)) {
  //pre-migrate
  Model m = getMach(env, mid); 
  for(UUID miid <- m.instances) {
    Model mi = getMachInst(env, miid);
    UUID siid = mi.sis[sid];
    env = eval(env, MachInstRemoveStateInst(miid, sid, siid));
    env = eval(env, StateInstDelete(siid, sid));
    env = eval(env, MachInstInitialize(miid));
  }
  //remove the state
  env = visit(env) {
    case mach(UUID mid, ID name, list[UUID] states, list[UUID] instances) =>
      mach(mid, name, states - [sid], instances)
  }
  return env;
}

public /*side-effect*/ Env eval(Env env, Command cmd: MachAddMachInst(UUID mid, UUID miid)) {
  env = visit(env) {
    case mach(UUID mid, ID name, list[UUID] states, list[UUID] instances) =>
      mach(mid, name, states, instances + [miid])
  }
  return env;
}

public /*inverse side-effect*/ Env eval(Env env, Command cmd: MachRemoveMachInst(UUID mid, UUID miid)) {
  env = visit(env) {
    case mach(UUID mid, ID name, list[UUID] states, list[UUID] instances) =>
      mach(mid, name, states, instances - [miid])
  }
  return env;
}

public /*invertible effect*/ Env eval(Env env, Command cmd: MachSetName(UUID mid, ID name)) {
  //fixme: old name is missing
  env = visit(env) {
    case mach(UUID mid, _, list[UUID] es, list[UUID] instances) =>
      mach(mid, name, es, instances)
  }
  return env;
}

public /*effect*/ Env eval(Env env, Command cmd: StateCreate(UUID sid, UUID mid)) {
  Model s = state(sid, mid, "", [], [], 0, 0);
  env = env_store(env, sid, s);

  //post-migrate
  env = eval(env, MachAddState(mid, sid));
  return env;
}

public /*inverse effect*/ Env eval(Env env, Command cmd: StateDelete(UUID sid)) {
  //pre-migrate
  Model s = getState(env, sid);
  for(UUID tid <- s.to) { env = eval(env, TransDelete(tid)); }
  for(UUID tid <- s.ti) { env = eval(env, TransDelete(tid)); }
  env = eval(env, MachRemoveState(s.mid, sid));

  //delete the state
  env = env_delete(env, sid);
  return env;
}

public /*invertible effect*/ Env eval(Env env, Command cmd: StateSetName(UUID sid, ID name)){
  env = visit(env) {
    case state(sid, UUID mid, _, list[UUID] ti, list[UUID] to, x, y) =>
      state(sid, mid, name, ti, to, x, y)
  }
  return env;
}

public /*side-effect*/ Env eval(Env env, Command cmd: StateAddIn(UUID sid, UUID tid)) {
  env = visit(env) {
    case state(sid, UUID mid, ID name, list[UUID] ti, list[UUID] to, x, y) =>
      state(sid, mid, name, ti + [tid], to, x, y)
  }
  return env;
}

public /*inverse side-effect*/ Env eval(Env env, Command cmd: StateRemoveIn(UUID sid, UUID tid)) {
  env = visit(env) {
    case state(sid, UUID mid, ID name, list[UUID] ti, list[UUID] to, x, y) =>
      state(sid, mid, name, ti - [tid], to, x, y)
  }
  return env;
}

public /*side-effect*/ Env eval(Env env, Command cmd: StateAddOut(UUID sid, UUID tid)) {
  env = visit(env) {
    case state(sid, UUID mid, ID name, list[UUID] ti, list[UUID] to, x, y) =>
      state(sid, mid, name, ti, to + [tid], x, y)
  }
  return env;
}

public /*inverse side-effect*/ Env eval(Env env, Command cmd: StateRemoveOut(UUID sid, UUID tid)) {
  env = visit(env) {
    case state(sid, UUID mid, ID name, list[UUID] ti, list[UUID] to, x, y) =>
      state(sid, mid, name, ti, to - [tid], x, y)
  }
  return env;
}

public /*effect*/ Env eval(Env env, Command cmd: TransCreateSource(UUID tid, UUID src)) {
  //fixme: missing parameters
  Model t = trans(tid, src, "", -1);
  env = env_store(env, tid, t);
  env = eval(env, StateAddOut(src, tid));
  return env;
}

public /*effect*/ Env eval(Env env, Command cmd: TransCreate(UUID tid, UUID src, UUID tgt)) {
  //fixme: missing parameters
  env = eval(env, TransCreateSource(tid, src));
  env = eval(env, TransSetTarget(tid, tgt));
  return env;
}

public /*inverse *effect*/ Env eval(Env env, Command cmd: TransDelete(UUID tid)) {
  //fixme: missing parameters
  //pre-migrate
  Model t = getTrans(env, tid);
  env = eval(env, StateRemoveOut(t.src, tid));
  env = eval(env, StateRemoveIn(t.tgt, tid));

  //delete the transition
  env = env_delete(env, tid);
  return env;
}

public /*invertible effect*/ Env eval(Env env, Command cmd: TransSetTarget(UUID tid, UUID tgt)){
  //fixme: add old value
  //pre-migrate
  Model t = getTrans(env, tid);
  if(t.tgt != -1){
    env = eval(env, StateRemoveIn(t.tgt, tid));
  }

  //set the target
  env = visit(env) {
    case trans(tid, UUID src, ID trigger, _) => trans(tid, src, trigger, tgt)
  }

  //post-migrate
  env = eval(env, StateAddIn(tgt, tid));
  return env;
}

public /*invertible effect*/ Env eval(Env env, Command cmd: TransSetTrigger(UUID tid, ID trigger)) {
  //fixme: missing old value
  env = visit(env) {
    case trans(tid, UUID src, _, UUID tgt) => trans(tid, src, trigger, tgt)
  }
  return env;
}