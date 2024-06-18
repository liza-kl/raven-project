module lang::sml::model::PrettyPrinter

import lang::sml::model::Model;
import lang::sml::Environment;

public str print(Env env, Model m: mach(UUID id, str name, list[UUID] states, list[UUID] instanes)) = 
  "machine <name>
  '  <for(s <- states){><print(env, getState(env, s))><}>";

public str print(Env env, Model s: state(UUID id, UUID mid, str name, list[UUID] ti, list[UUID] to, int x, int y)) = 
  "state <name> @(<x>,<y>)<for(t <- to){>
  '  <print(env, getTrans(env,t))><}>
  ";

public str print(Env env, Model t: trans(UUID id, UUID src, str trigger, UUID tgt)) = 
  "  <trigger> -\> <env[tgt].name>";