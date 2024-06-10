module lang::Main

import IO;
import lang::raven::Environment;
import lang::raven::RavenNode;
import lang::sml::model::Model;
import lang::sml::model::Command;
import lang::sml::model::REPL;
import lang::sml::model::PrettyPrinter;
import lang::sml::model::Renderer;
import lang::sml::control::ViewCommand;
import lang::sml::runtime::Model;
import lang::sml::runtime::Command;
import lang::sml::runtime::REPL;
import lang::sml::runtime::PrettyPrinter;
import lang::sml::control::REPL;
import lang::raven::JSONMapper;
import lang::raven::helpers::Server;
import ApplicationConf;
import Map;
public data ViewEnv = view(map[int vid, Tab tab] currentTabs); // Except the initial screen I guess.
public data InputEnv = input(list[value] stagedValues);
public data ViewMIDMap = viewMID(map[int vid, int mid] mappings);

public Env env = (0: meta(5), 1: view(()), 2: input([]),3 : viewMID(()));

list[Env] envClosure() {
Env env = (0: meta(2), 1: view(()), 2: input([]));
return [env];
}

UUID env_retrieveMIDfromVID(UUID vid) {
      map[int, int] viewMID = env_retrieve(env, #ViewMIDMap, 3).mappings;
      return viewMID[vid];
}

list[UUID] env_retrieveVIDfromMID(UUID mid) {
    println("calling env_retrieveVIDfromMID");
    ViewMIDMap viewMID = env_retrieve(env, #ViewMIDMap, 3);
    list[UUID] result = [view | view <- viewMID.mappings, viewMID.mappings[view] == mid];
    return result;
}
void main() { 

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

  // println(print(env, env[mid]));  //complete door machine

  // <env, miid> = env_getNextId(env); 
  // env = eval(env, MachInstCreate(miid, mid));
  // println(print(env, env[miid])); //running door machine

  // env = eval(env, MachInstTrigger(miid, "close"));
  // println(print(env, env[miid])); //transition to closed

  // env = eval(env, StateDelete(sid2)); //delete the current state!

  // println(print(env, env[mid]));  //state and transitions cleaned up
  // println(print(env, env[miid])); //run-time state migrated

  // iprintln(env);

  // <env, sid3> = env_getNextId(env); 
  // env = eval(env, StateCreate(sid3, mid));
  // env = eval(env, StateSetName(sid3, "blabla"));
  // env = eval(env, MachDelete(mid)); //deletes everything
  // iprintln(env); //empty environment = all cleaned up!


  RavenNode view = render(env);
  genJSON(view);
}

void init() {
 // lang::raven::helpers::Server::send("THEME_INIT:" + readFile(JSON_STYLING_FILE));
  lang::raven::helpers::Server::send("VIEW_UPDATE:" + readFile(JSON_TREE_FILE));
}