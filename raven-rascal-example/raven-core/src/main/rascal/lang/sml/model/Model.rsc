module lang::sml::model::Model

import lang::sml::Environment;
alias ID = str;

data Model
  //= empty()
  = mach(UUID mid,             //machine UUID
         ID name,              //machine name
         list[UUID] states,    //states
         list[UUID] instances) //machine instance UUIDs
  | state(UUID sid,            //state UUID 
          UUID mid,            //defining machine UUID
          ID name,             //state name
          list[UUID] ti,       //transitions input
          list[UUID] to,       //transitions output
          int x, int y)        //visual coorinate
  | trans(UUID tid,            //transition UUID
          UUID src,            //source state UUID
          ID trigger,          //transition trigger
          UUID tgt)            //target state UUID
  ;

public Model getMach(Env env, UUID id) {
  Model n = env_retrieve(env, #Model, id);
  if(Model m: mach(id,_,_,_):= n) {
    return m;
  }
  throw "Expected Mach <id>, found <n>";
}

public Model getState(Env env, UUID id) {
  Model n = env_retrieve(env, #Model, id);
  if(Model s: state(id,_,_,_,_,_,_) := n) {
    return s;
  }
  throw "Expected State <id>, found <n>";
}

public Model getTrans(Env env, UUID id) {
  Model n = env_retrieve(env, #Model, id);
  if(Model t: trans(id,_,_,_) := n) {
    return t;
  }
  throw "Expected Trans <id>, found <n>";
}