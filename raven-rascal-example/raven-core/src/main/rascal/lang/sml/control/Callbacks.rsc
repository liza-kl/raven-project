module lang::sml::control::Callbacks

// STANDARD
import IO;
import Type;
import List;
// CONFIG
import ApplicationConf;
import lang::raven::helpers::Server;
// RAVEN MODULES
import lang::raven::JSONMapper;
import lang::sml::Environment;
// MODEL
import lang::sml::model::Command;
import lang::sml::model::REPL;
import lang::sml::model::Model;
import lang::sml::model::Renderer;
import lang::Main;
// VIEW Callbacks
import lang::sml::control::REPL;
import lang::sml::control::ViewCallbacks;
import lang::sml::control::ViewCommand;
import lang::sml::runtime::RuntimeCallbacks;

public void viewControl(Command incomingCallback: MachCreate(UUID mid)) {
  //  IO::println("Calling MachCreate");
    lang::Main::env = eval(env, MachCreate(mid));
    env = updateMachines(env);

    //lang::raven::JSONMapper::genJSON(render(env));
      lang::raven::helpers::Server::send("VIEW_UPDATE:" + genJSONStr(render(env)));
  //  lang::raven::helpers::Server::send("VIEW_UPDATE:" + readFile(ApplicationConf::JSON_TREE_FILE));
}

public void viewControl(Command incomingCallback: MachDelete(UUID mid)) {
  //  println("Calling MachDelete");
    lang::Main::env = eval(env, MachDelete(mid));
    list[int] vidToDelete = env_retrieveVIDfromMID(mid);

    for (v <- vidToDelete) {
    lang::Main::env = lang::sml::control::REPL::eval(lang::Main::env, ViewTabDelete(v));
    }
    env = updateMachines(env);
    
    lang::raven::helpers::Server::send("VIEW_UPDATE:" + genJSONStr(render(env)));

    // lang::raven::JSONMapper::genJSON(render(env));
    // lang::raven::helpers::Server::send("VIEW_UPDATE:" + readFile(ApplicationConf::JSON_TREE_FILE));
}

public void viewControl(Command incomingCallback: MachSetName(UUID mid, ID name)) {
   // println("Calling MachSetName");
    env = eval(env, MachSetName(mid,name));
    env = updateMachines(env);
    lang::raven::helpers::Server::send("VIEW_UPDATE:" + genJSONStr(render(env)));
    // lang::raven::JSONMapper::genJSON(render(env));
    // lang::raven::helpers::Server::send("VIEW_UPDATE:" + readFile(ApplicationConf::JSON_TREE_FILE));
}

public void viewControl(Command incomingCallback: StateCreate(UUID sid, UUID mid)) {
    //println("Calling StateCreate");  
    
    env = eval(env, StateCreate(sid,mid));
    Model m = getMach(env, mid);
    env = updateMachines(env);
    lang::raven::helpers::Server::send("VIEW_UPDATE:" + genJSONStr(render(env)));
    // lang::raven::JSONMapper::genJSON(render(env));
    // lang::raven::helpers::Server::send("VIEW_UPDATE:" + readFile(ApplicationConf::JSON_TREE_FILE));
}

public void viewControl(Command incomingCallback: StateSetName(UUID sid, ID name)) {
   // println("Calling StateSetName");
    env = eval(env, StateSetName(sid,name));

    UUID mid = env_retrieveMIDfromSID(sid);
    list[int] vid = env_retrieveVIDfromMID(mid);
    env = updateMachines(env);
    lang::raven::helpers::Server::send("VIEW_UPDATE:" + genJSONStr(render(env)));
    // lang::raven::JSONMapper::genJSON(render(env));
    // lang::raven::helpers::Server::send("VIEW_UPDATE:" + readFile(ApplicationConf::JSON_TREE_FILE));
}

public void viewControl(Command incomingCallback: StateDelete(UUID sid)) {
    //println("StateDelete(UUID sid)");
    UUID mid = env_retrieveMIDfromSID(sid);
    lang::Main::env = eval(env, StateDelete(sid));
    env = updateMachines(env);
    lang::raven::helpers::Server::send("VIEW_UPDATE:" + genJSONStr(render(env)));
    // lang::raven::JSONMapper::genJSON(render(env));
    // lang::raven::helpers::Server::send("VIEW_UPDATE:" + readFile(ApplicationConf::JSON_TREE_FILE));
}

public void viewControl(Command incomingCallback: TransCreate(UUID tid, UUID src, UUID tgt)) {
   // println("TransCreate(UUID tid, UUID src, UUID tgt))");
    env = eval(env, TransCreate( tid,  src,  tgt));
    // src is a state, so we can apply the same functions as before.

    // UUID mid = env_retrieveMIDfromSID(src);
    // list[int] vid = env_retrieveVIDfromMID(mid);
    // for (int v <- vid) {
    //     env = eval(env,ViewTabSetMachine(v, mid));
    // }

    env = updateMachines(env);

    lang::raven::helpers::Server::send("VIEW_UPDATE:" + genJSONStr(render(env)));
    // lang::raven::JSONMapper::genJSON(render(env));
    // lang::raven::helpers::Server::send("VIEW_UPDATE:" + readFile(ApplicationConf::JSON_TREE_FILE));
}

public void viewControl(Command incomingCallback: TransCreateSource(UUID tid, UUID src)) {
    println("TransCreateSource(UUID tid, UUID src))");
    println("env before trans create source");
    println(env);
    env = eval(env, TransCreateSource( tid,src));
// Fixing
    UUID mid = env_retrieveMIDfromSID(src);
    list[int] vid = env_retrieveVIDfromMID(mid);
    for (int v <- vid) {
        lang::Main::env = eval(env,ViewTabSetMachine(v, mid));
    }
    env = updateMachines(env);

   lang::raven::helpers::Server::send("VIEW_UPDATE:" + genJSONStr(render(env)));
    // lang::raven::JSONMapper::genJSON(render(env));
    // lang::raven::helpers::Server::send("VIEW_UPDATE:" + readFile(ApplicationConf::JSON_TREE_FILE));
}

public void viewControl(Command incomingCallback: TransSetTarget(UUID tid, UUID tgt)) {
  //  println("TransSetTarget(UUID tid, UUID src, UUID tgt))");
    lang::Main::env = eval(env, TransSetTarget( tid,tgt));
    UUID mid = env_retrieveMIDfromSID(tgt);
    // list[int] vid = env_retrieveVIDfromMID(mid);
    // for (int v <- vid) {
    //     lang::Main::env = eval(env,ViewTabSetMachine(v, mid));
    // }
    env = updateMachines(env);
    lang::raven::helpers::Server::send("VIEW_UPDATE:" + genJSONStr(render(env)));
    // lang::raven::JSONMapper::genJSON(render(env));
    // lang::raven::helpers::Server::send("VIEW_UPDATE:" + readFile(ApplicationConf::JSON_TREE_FILE));
}

public void viewControl(Command incomingCallback: TransSetTrigger(UUID tid, ID trigger)) {
   // println("TransSetTrigger(UUID tid, UUID src, UUID tgt))");
    //UUID mid = env_retrieveMIDfromTID(tid);
    env = eval(env, TransSetTrigger( tid,trigger));
    //  list[int] vid = env_retrieveVIDfromMID(mid);
    // for (int v <- vid) {
    //     lang::Main::env = eval(env,ViewTabSetMachine(v, mid));
    // }
    env = updateMachines(env);
    lang::raven::helpers::Server::send("VIEW_UPDATE:" + genJSONStr(render(env)));
    // lang::raven::JSONMapper::genJSON(render(env));
    // lang::raven::helpers::Server::send("VIEW_UPDATE:" + readFile(ApplicationConf::JSON_TREE_FILE));
}

public void viewControl(Command incomingCallback: TransDelete(UUID tid)) {
  //  println("TransDelete(UUID tid)");
    UUID mid = env_retrieveMIDfromTID(tid);
    lang::Main::env = eval(env, TransDelete(tid));
    // list[int] vid = env_retrieveVIDfromMID(mid);
    // for (int v <- vid) {
    //     lang::Main::env = eval(env,ViewTabSetMachine(v, mid));
    // }
    env = updateMachines(env);
   lang::raven::helpers::Server::send("VIEW_UPDATE:" + genJSONStr(render(env)));
    // lang::raven::JSONMapper::genJSON(render(env));
    // lang::raven::helpers::Server::send("VIEW_UPDATE:" + readFile(ApplicationConf::JSON_TREE_FILE));
}

// TODO need to put this helper function somewhere else.
public void viewControl(Command incomingCallback: InterTransSetTarget(UUID id, str targetStateName)) {
  //  IO::println("Calling InterTransSetTarget(<id>, <targetStateName>)");
    UUID tgt = lang::Main::env_retrieveSIDfromName(targetStateName);
    viewControl(TransSetTarget(id,tgt)); 
}

public default void viewControl(Command incomingCallback) { 
    throw "No Control function callback of type <typeOf(incomingCallback)>"; } 
