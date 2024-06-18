module lang::sml::Environment
import Map;
import lang::sml::control::AST;

alias RavenNodeAttributes = list[value]; 
alias RavenNodeName = str;


alias UUID = int;
alias Env = map[UUID id, node n];

/*
* META: Bookkeeping Information for the taken IDs in the environment
* Not language specific, 
* Control knows how to render, which tabs are open and what there IDs are. 
* State Machines. 
* Asks for a next id, checks in t
*/ 
data MetaEnv = meta(int nextId);


// Reserved Env within the Env?
private int META_ID = 0;

public tuple[Env, UUID] env_getNextId(Env env) {
  MetaEnv me = env_retrieve(env, #MetaEnv, META_ID);
  // TODO hackedy hackedy do.
  UUID nextId = me.nextId + 1;
  while(nextId in domain(env)) {
    nextId = nextId + 1;
  }
  env = env_store(env, META_ID, meta(nextId));
  return <env, nextId>;
}

public &T env_retrieve(Env env, type[&T] t, UUID id) {
  node n = env[id];
  if (&T r := n) return r;
  throw "Expected value of type <t>, found value <n>";
}

public Env env_store(Env env, UUID id, node n) {
  env[id] = n;
  return env;
}

public Env env_delete(Env env, UUID id) {
  return delete(env, id); 
}