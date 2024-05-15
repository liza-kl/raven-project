module lang::Main

import IO;

import lang::sml::AST;
import lang::sml::Command;
import lang::sml::REPL;
import lang::sml::PrettyPrinter;
import lang::sml::Renderer;

public Env ENVIRONMENT = (0: empty());

Env initLanguage() {
  return ENVIRONMENT;
}

int main(int testArgument=0) {
  Env env = ();
  env = eval(env, MachCreate(1));
  env = eval(env, MachSetName(1, "door"));
  env = eval(env, StateCreate(2,1));
  env = eval(env, StateSetName(2, "opened"));
  env = eval(env, TransCreate(3, 2, 4));
  env = eval(env, TransSetTrigger(3, "close"));
  env = eval(env, StateCreate(4, 1));
  env = eval(env, StateSetName(4, "closed"));
  env = eval(env, TransCreate(5, 4, 2));
  env = eval(env, TransSetTrigger(5, "open"));
  str program = print(env, env[1]);
 // println(program);
  return testArgument;
}
