module lang::sml::REPL

import lang::sml::AST;
import lang::sml::Command;

import Map;

//This is a REPL interpreter for SML.
//todo: add interpreter for machine instances (running machines)

UUID UUID_NONE = 0;  //an element has no id
ID ID_NONE = "";     //an element has no name (yet)

Env eval(Env env, Command cmd: MachCreate(UUID mid)) {
  AST m = machine(mid, ID_NONE, []);
  env[mid] = m;
  return env;
}

Env eval(Env env, Command cmd: MachSetName(UUID mid, ID name)) {
  //rename the machine in the environment
  env[mid].name = name;
  return env;
}

Env eval(Env env, Command cmd: MachDelete(UUID mid)) {
  //remove all states
  for(AST s: state(UUID sid, mid, _, _) <- env[mid].es) {
    env = eval(env, StateDelete(sid));
  }

  //delete the machine
  env = delete(env, mid);
  return env;
}

Env eval(Env env, Command cmd: StateCreate(UUID sid, UUID mid)) {
  AST s = state(sid, mid, ID_NONE, []);
  env[sid] = s;
  env[mid].es += [s];
  return env;
}

Env eval(Env env, Command cmd: StateSetName(UUID sid, ID name)){
  //rename the state in the environment
  env = visit(env) {
    case state(sid, UUID mid, _, list[AST] ts) => state(sid, mid, name, ts)
  };

  return env;
}

Env eval(Env env, Command cmd: StateDelete(UUID sid)) {
  //delete all tranitions of the state
  AST s = env[sid];
  for(AST t: trans(UUID tid, _, _, _) <- s.ts) {
    env = eval(env, TransDelete(tid));
  }

  //remove the state from its machine
  UUID mid = s.mid;
  AST m = env[mid];
  m.es = m.es - s;
  env[mid] = m;

  //delete the state
  env = delete(env, sid);
  return env;
}

Env eval(Env env, Command cmd: TransCreate(UUID tid, UUID src)) {
  //create a new transition and store it
  AST t = trans(tid, src, ID_NONE, UUID_NONE);
  env[tid] = t;
  
  //retrieve the state and its parent machine
  AST s = env[src];
  UUID mid = s.mid;

  //update the environment with the updated state
  env = visit(env) {
    case state(src, UUID mid, ID name, list[AST] es) => state(src, mid, name, es + [t])
  };

  return env;
}

Env eval(Env env, Command cmd: TransCreate(UUID tid, UUID src, UUID tgt)) {
   //create the transition
   env = eval(env, TransCreate(tid, src));

   //set its target
   env = eval(env, TransSetTarget(tid, tgt));
   return env;
}

Env eval(Env env, Command cmd: TransSetTarget(UUID tid, UUID tgt)){
  //set the target of a transition in the environment
  env = visit(env) {
    case trans(tid, UUID src, ID trigger, _) => trans(tid, src, trigger, tgt)
  };

  return env;
}

Env eval(Env env, Command cmd: TransSetTrigger(UUID tid, ID trigger)){
  //rename the trigger in the environment
  env = visit(env) {
    case trans(tid, UUID src, _, UUID tgt) => trans(tid, src, trigger, tgt)
  };

  return env;
}

Env eval(Env env, Command cmd: TransDelete(UUID tid))
{
  AST t = env[tid];
  UUID sid = t.src;

  //update the environment with the updated state
  env = visit(env) {
    case state(sid, UUID mid, ID name, list[AST] ts) => state(sid, mid, name, ts - [t])
  };

  //delete the transition
  env = delete(env, tid);
  return env;
}
