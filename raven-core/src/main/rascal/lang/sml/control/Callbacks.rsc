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

public void viewControl(Command incomingCallback: MachCreate(UUID mid)) {
    IO::println("Calling MachCreate");
    
    lang::raven::helpers::Server::send("VIEW_UPDATE:" + readFile(ApplicationConf::JSON_TREE_FILE));
}

public void viewControl(Command incomingCallback: MachDelete(UUID mid)) {
    println("Calling MachDelete");
    lang::raven::helpers::Server::send("VIEW_UPDATE:" + readFile(ApplicationConf::JSON_TREE_FILE));
}

public void viewControl(Command incomingCallback: MachSetName(UUID mid, ID name)) {
    println("Calling MachSetName");
    lang::raven::helpers::Server::send("VIEW_UPDATE:" + readFile(ApplicationConf::JSON_TREE_FILE));
}

public void viewControl(Command incomingCallback: StateCreate(UUID sid, UUID mid)) {
    println("Calling StateCreate");  
    lang::raven::helpers::Server::send("VIEW_UPDATE:" + readFile(ApplicationConf::JSON_TREE_FILE));
}

public void viewControl(Command incomingCallback: StateSetName(UUID sid, ID name)) {
    println("Calling StateSetName");
    lang::raven::helpers::Server::send("VIEW_UPDATE:" + readFile(ApplicationConf::JSON_TREE_FILE));
}

public void viewControl(Command incomingCallback: StateDelete(UUID sid)) {
    println("StateDelete(UUID sid)");
    lang::raven::helpers::Server::send("VIEW_UPDATE:" + readFile(ApplicationConf::JSON_TREE_FILE));
}

// public void viewControl(Command incomingCallback: TransCreate(UUID tid, UUID src)) {
//     println("TransCreate(UUID tid, UUID src)");
//     lang::raven::helpers::Server::send("VIEW_UPDATE:" + readFile(ApplicationConf::JSON_TREE_FILE));
// }

public void viewControl(Command incomingCallback: TransCreate(UUID tid, UUID src, UUID tgt)) {
    println("TransCreate(UUID tid, UUID src, UUID tgt))");
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
