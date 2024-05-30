module lang::raven::Env
import Map;

alias UUID = int;
alias Env = map[UUID id, node n];

data MetaEnv = meta(int nextId);

private int META_ID = 0;

public tuple[Env, UUID] env_getNextId(Env env) {
  MetaEnv me = env_retrieve(env, #MetaEnv, META_ID);
  UUID nextId = me.nextId + 1;
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