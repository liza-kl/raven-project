module lang::sml::control::REPL

import Interpreter::RavenNode;
import lang::sml::control::AST;
import Interpreter::JSONMapper;
import lang::sml::AST;
import ApplicationConf;
import lang::sml::Command;
import Helpers::Server;
import lang::sml::REPL;
import lang::sml::Renderer;
import IO;
import Main;
import Type;
import util::Math;
import List;
BookKeeping myBook = [<1, lang::sml::control::AST::tree()>];
// Memory Leak with ENV. 
public Env ENV = (0:empty());

// We need to append the tab container only once?
// Imports arent transitive
// Store public values should be in a function
public RavenNode currentRavenNode = appendTabContainer(render(ENV));

public void viewControl(Command incomingCallback: MachCreate(UUID mid)) {
    println("Calling MachCreate");
    // todo add here the views.
    // todo experiencing memory leaks need to fix.
    myBook += <mid, lang::sml::control::AST::tree()>;
    // First need to fire MachCreate and then the visual part <3
    ENV = lang::sml::REPL::eval(ENV, incomingCallback);
        println("ENV");
    println(ENV);
//    list[View] neededViews = [v | <uuid, v> <- myBook, uuid == mid];
   // for (View view <- neededViews) {

    RavenNode rendered = render(ENV, machine(mid, toString(mid), []), tree());
    println("rendered");
    println(rendered);
    currentRavenNode = top-down-break visit(currentRavenNode) {
        case ravenTabContainer(list[RavenNode] r) => {
        println("rrrr");
        println(r);
        r[0] = render(ENV);

        println("updated r");
        println(        r + rendered);
      
        ravenTabContainer(        r + rendered);
       }
  
    };
   // }
   println("current raevn node");
   println(currentRavenNode);
   genJSON(currentRavenNode);
   Helpers::Server::send("VIEW_UPDATE:" + readFile(ApplicationConf::JSON_TREE_FILE));
}


public void viewControl(Command incomingCallback: MachDelete(UUID mid)) {
    println("Calling MachDelete");

    Helpers::Server::send("VIEW_UPDATE:" + readFile(ApplicationConf::JSON_TREE_FILE));
}

public void viewControl(Command incomingCallback:  MachSetName(UUID mid, ID name)) {
    println("Calling MachSetName");
    Helpers::Server::send("VIEW_UPDATE:" + readFile(ApplicationConf::JSON_TREE_FILE));
}

public void viewControl(Command incomingCallback: StateCreate(UUID sid, UUID mid)) {
    println("Calling StateCreate");
    Helpers::Server::send("VIEW_UPDATE:" + readFile(ApplicationConf::JSON_TREE_FILE));
}

public void viewControl(Command incomingCallback: StateSetName(UUID sid, ID name)) {
    println("Calling StateSetName");
    Helpers::Server::send("VIEW_UPDATE:" + readFile(ApplicationConf::JSON_TREE_FILE));
}

public void viewControl(Command incomingCallback: StateDelete(UUID sid)) {
    println("StateDelete(UUID sid)");
    Helpers::Server::send("VIEW_UPDATE:" + readFile(ApplicationConf::JSON_TREE_FILE));
}

public void viewControl(Command incomingCallback: TransCreate(UUID tid, UUID src)) {
    println("TransCreate(UUID tid, UUID src)");
    Helpers::Server::send("VIEW_UPDATE:" + readFile(ApplicationConf::JSON_TREE_FILE));
}


public void viewControl(Command incomingCallback: TransCreate(UUID tid, UUID src, UUID tgt)) {
    println("TransCreate(UUID tid, UUID src, UUID tgt))");
    Helpers::Server::send("VIEW_UPDATE:" + readFile(ApplicationConf::JSON_TREE_FILE));
}

public void viewControl(Command incomingCallback: TransSetTarget(UUID tid, UUID tgt)) {
    println("TransCreate(UUID tid, UUID src, UUID tgt))");
    Helpers::Server::send("VIEW_UPDATE:" + readFile(ApplicationConf::JSON_TREE_FILE));
}

public void viewControl(Command incomingCallback: TransSetTrigger(UUID tid, ID trigger)) {
    println("TransCreate(UUID tid, UUID src, UUID tgt))");
    Helpers::Server::send("VIEW_UPDATE:" + readFile(ApplicationConf::JSON_TREE_FILE));
}

public void viewControl(Command incomingCallback: TransDelete(UUID tid)) {
    println("TransCreate(UUID tid, UUID src, UUID tgt))");
    Helpers::Server::send("VIEW_UPDATE:" + readFile(ApplicationConf::JSON_TREE_FILE));
}


public default void viewControl(Command incomingCallback) { 
    throw "No Control function callback of type <typeOf(incomingCallback)>"; } 
