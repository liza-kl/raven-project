module lang::sml::PrettyPrinter

import lang::sml::AST;
import lang::sml::Command;

public str print(Env env, AST e: empty()) = "";

public str print(Env env, AST m: machine(UUID id, str name, list[AST] es)) = 
  "machine <name>
  '  <for(e <- es){><print(env, e)><}>";

public str print(Env env, AST s: state(UUID id, UUID mid, str name, list[AST] ts)) = 
  "state <name><for(t <- ts){>
  '  <print(env, t)><}>
  ";

public str print(Env env, AST t: trans(UUID id, UUID src, str trigger, UUID tgt)) = 
  "  <trigger> -\> <env[tgt].name>";