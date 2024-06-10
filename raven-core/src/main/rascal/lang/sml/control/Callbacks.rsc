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
import lang::raven::Environment;
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

public void viewControl(Command incomingCallback: MachCreate(UUID mid)) {
    IO::println("Calling MachCreate");
    lang::Main::env = eval(env, MachCreate(mid));

    list[int] vid = env_retrieveVIDfromMID(mid);
    lang::raven::JSONMapper::genJSON(render(env));
    lang::raven::helpers::Server::send("VIEW_UPDATE:" + readFile(ApplicationConf::JSON_TREE_FILE));
}

public void viewControl(Command incomingCallback: MachDelete(UUID mid)) {
    println("Calling MachDelete");
    lang::Main::env = eval(env, MachDelete(mid));
    list[int] vidToDelete = env_retrieveVIDfromMID(mid);

    for (v <- vidToDelete) {
    lang::Main::env = lang::sml::control::REPL::eval(lang::Main::env, ViewTabDelete(v));
    }
    lang::raven::JSONMapper::genJSON(render(env));
    lang::raven::helpers::Server::send("VIEW_UPDATE:" + readFile(ApplicationConf::JSON_TREE_FILE));
}

public void viewControl(Command incomingCallback: MachSetName(UUID mid, ID name)) {
    println("Calling MachSetName");
    lang::Main::env = eval(env, MachSetName(mid,name));
    lang::raven::JSONMapper::genJSON(render(env));
    lang::raven::helpers::Server::send("VIEW_UPDATE:" + readFile(ApplicationConf::JSON_TREE_FILE));
}

public void viewControl(Command incomingCallback: StateCreate(UUID sid, UUID mid)) {
    println("Calling StateCreate");  
    lang::Main::env = eval(env, StateCreate(sid,mid));
    list[int] vid = env_retrieveVIDfromMID(mid);
    for (int v <- vid) {
        lang::Main::env = eval(env,ViewTabSetMachine(v, mid));
    }

    lang::raven::JSONMapper::genJSON(render(env));
    lang::raven::helpers::Server::send("VIEW_UPDATE:" + readFile(ApplicationConf::JSON_TREE_FILE));
}

public void viewControl(Command incomingCallback: StateSetName(UUID sid, ID name)) {
    println("Calling StateSetName");
    lang::Main::env = eval(env, StateSetName(sid,name));

    UUID mid = env_retrieveMIDfromSID(sid);
    list[int] vid = env_retrieveVIDfromMID(mid);
    for (int v <- vid) {
        lang::Main::env = eval(env,ViewTabSetMachine(v, mid));
    }

    lang::raven::JSONMapper::genJSON(render(env));
    lang::raven::helpers::Server::send("VIEW_UPDATE:" + readFile(ApplicationConf::JSON_TREE_FILE));
}

public void viewControl(Command incomingCallback: StateDelete(UUID sid)) {
    println("StateDelete(UUID sid)");
    UUID mid = env_retrieveMIDfromSID(sid);
    lang::Main::env = eval(env, StateDelete(sid));
    list[int] vid = env_retrieveVIDfromMID(mid);
    for (int v <- vid) {
        lang::Main::env = eval(env,ViewTabSetMachine(v, mid));
    }
    lang::raven::JSONMapper::genJSON(render(env));
    lang::raven::helpers::Server::send("VIEW_UPDATE:" + readFile(ApplicationConf::JSON_TREE_FILE));
}

public void viewControl(Command incomingCallback: TransCreate(UUID tid, UUID src, UUID tgt)) {
    println("TransCreate(UUID tid, UUID src, UUID tgt))");
    lang::Main::env = eval(env, TransCreate( tid,  src,  tgt));
    lang::raven::JSONMapper::genJSON(render(env));
    lang::raven::helpers::Server::send("VIEW_UPDATE:" + readFile(ApplicationConf::JSON_TREE_FILE));
}

public void viewControl(Command incomingCallback: TransCreateSource(UUID tid, UUID src)) {
    println("TransCreateSource(UUID tid, UUID src))");
    lang::Main::env = eval(env, TransCreateSource( tid,src));
    lang::raven::JSONMapper::genJSON(render(env));
    lang::raven::helpers::Server::send("VIEW_UPDATE:" + readFile(ApplicationConf::JSON_TREE_FILE));
}

public void viewControl(Command incomingCallback: TransSetTarget(UUID tid, UUID tgt)) {
    println("TransCreate(UUID tid, UUID src, UUID tgt))");
    lang::Main::env = eval(env, TransSetTarget( tid,tgt));
    lang::raven::JSONMapper::genJSON(render(env));
    lang::raven::helpers::Server::send("VIEW_UPDATE:" + readFile(ApplicationConf::JSON_TREE_FILE));
}

public void viewControl(Command incomingCallback: TransSetTrigger(UUID tid, ID trigger)) {
    println("TransCreate(UUID tid, UUID src, UUID tgt))");
    lang::Main::env = eval(env, TransSetTrigger( tid,trigger));
    lang::raven::JSONMapper::genJSON(render(env));
    lang::raven::helpers::Server::send("VIEW_UPDATE:" + readFile(ApplicationConf::JSON_TREE_FILE));
}

public void viewControl(Command incomingCallback: TransDelete(UUID tid)) {
    println("TransCreate(UUID tid, UUID src, UUID tgt))");
    lang::Main::env = eval(env, TransDelete(tid));
    lang::raven::JSONMapper::genJSON(render(env));
    lang::raven::helpers::Server::send("VIEW_UPDATE:" + readFile(ApplicationConf::JSON_TREE_FILE));
}

public default void viewControl(Command incomingCallback) { 
    throw "No Control function callback of type <typeOf(incomingCallback)>"; } 
