module lang::Main

import IO;
import lang::raven::Env;

import lang::sml::model::Model;
import lang::sml::model::Command;
import lang::sml::model::REPL;
import lang::sml::model::PrettyPrinter;
import lang::sml::model::Renderer;

import lang::sml::runtime::Model;
import lang::sml::runtime::Command;
import lang::sml::runtime::REPL;
import lang::sml::runtime::PrettyPrinter;

void main() {
  Env env = (0: meta(0));

  <env, mid> = env_getNextId(env);
  env = eval(env, MachCreate(mid));
  env = eval(env, MachSetName(mid, "door"));

  <env, sid1> = env_getNextId(env);  
  env = eval(env, StateCreate(sid1, mid));
  env = eval(env, StateSetName(sid1, "opened"));

  <env, sid2> = env_getNextId(env);  
  env = eval(env, StateCreate(sid2, mid));
  env = eval(env, StateSetName(sid2, "closed"));

  <env, tid1> = env_getNextId(env); 
  env = eval(env, TransCreate(tid1, sid1, sid2));
  env = eval(env, TransSetTrigger(tid1, "close"));

  <env, tid2> = env_getNextId(env); 
  env = eval(env, TransCreate(tid2, sid2, sid1));
  env = eval(env, TransSetTrigger(tid2, "open"));

  <env, miid> = env_getNextId(env); 
  env = eval(env, MachInstCreate(miid, mid));

  str program = print(env, env[mid]);
  println(program);

  str running = print(env, env[miid]);
  println(running);

  env = eval(env, MachInstTrigger(miid, "close"));

  str running2 = print(env, env[miid]);
  println(running2);

  iprintln(render(env));
}
