module lang::sml::runtime::Model

import lang::sml::Environment; 

data Model
  = machInst(UUID id,    //machine instance id
             UUID mid,   //defining machine
             UUID cur,   //current state instance
             map[UUID sid, UUID siid] sis) //sate instances
  | stateInst(UUID id,   //state instance id
              UUID sid,  //defining state
              int count) //visited count
  ;

public Model getMachInst(Env env, UUID id) {
  Model m = env_retrieve(env, #Model, id);
  if(Model mi: machInst(_,_,_,_) := m){
    return mi;
  }
  throw "Expected MachInst <id>, found <m>";
}

public Model getStateInst(Env env, UUID id) {
  Model m = env_retrieve(env, #Model, id);
  if(Model si: stateInst(_,_,_) := m){
    return si;
  }
  throw "Expected StateInst <id>, found <m>";
}