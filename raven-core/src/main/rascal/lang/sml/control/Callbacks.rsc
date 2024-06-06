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

public void viewControl(Command incomingCallback: MachCreate(UUID mid)) {
    IO::println("Calling MachCreate");
    lang::Main::env = eval(env, MachCreate(mid));
    lang::raven::JSONMapper::genJSON(render(env));
    lang::raven::helpers::Server::send("VIEW_UPDATE:" + readFile(ApplicationConf::JSON_TREE_FILE));
}

public void viewControl(Command incomingCallback: MachDelete(UUID mid)) {
    println("Calling MachDelete");
    lang::Main::env = eval(env, MachDelete(mid));
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
    lang::raven::JSONMapper::genJSON(render(env));
    lang::raven::helpers::Server::send("VIEW_UPDATE:" + readFile(ApplicationConf::JSON_TREE_FILE));
}

public void viewControl(Command incomingCallback: StateSetName(UUID sid, ID name)) {
    println("Calling StateSetName");
    lang::Main::env = eval(env, StateSetName(sid,name));
    lang::raven::JSONMapper::genJSON(render(env));
    lang::raven::helpers::Server::send("VIEW_UPDATE:" + readFile(ApplicationConf::JSON_TREE_FILE));
}

public void viewControl(Command incomingCallback: StateDelete(UUID sid)) {
    println("StateDelete(UUID sid)");
    lang::Main::env = eval(env, StateDelete(sid));
    lang::raven::JSONMapper::genJSON(render(env));
    lang::raven::helpers::Server::send("VIEW_UPDATE:" + readFile(ApplicationConf::JSON_TREE_FILE));
}

public void viewControl(Command incomingCallback: TransCreate(UUID tid, UUID src, UUID tgt)) {
    println("TransCreate(UUID tid, UUID src, UUID tgt))");
    lang::Main::env = eval(env, TransCreate( tid,  src,  tgt));
    lang::raven::JSONMapper::genJSON(render(env));
    lang::raven::helpers::Server::send("VIEW_UPDATE:" + readFile(ApplicationConf::JSON_TREE_FILE));
}

public void viewControl(Command incomingCallback: TransSetTarget(UUID tid, UUID tgt)) {
    println("TransCreate(UUID tid, UUID src, UUID tgt))");
    lang::raven::helpers::Server::send("VIEW_UPDATE:" + readFile(ApplicationConf::JSON_TREE_FILE));
}

public void viewControl(Command incomingCallback: TransSetTrigger(UUID tid, ID trigger)) {
    println("TransCreate(UUID tid, UUID src, UUID tgt))");
    lang::raven::helpers::Server::send("VIEW_UPDATE:" + readFile(ApplicationConf::JSON_TREE_FILE));
}

public void viewControl(Command incomingCallback: TransDelete(UUID tid)) {
    println("TransCreate(UUID tid, UUID src, UUID tgt))");
    lang::raven::helpers::Server::send("VIEW_UPDATE:" + readFile(ApplicationConf::JSON_TREE_FILE));
}

public default void viewControl(Command incomingCallback) { 
    throw "No Control function callback of type <typeOf(incomingCallback)>"; } 
