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

BookKeeping myBook = [<1, lang::sml::control::AST::tree()>];
public Env ENV = (0:empty());

// We need to append the tab container only once?
public RavenNode currentRavenNode = appendTabContainer(render(ENV));

public void viewControl(Command incomingCallback: MachCreate(UUID mid)) {
    println("Calling viewControl");
    // todo add here the views.
    myBook += <mid, lang::sml::control::AST::tree()>;
    // First need to fire MachCreate and then the visual part <3
    ENV = lang::sml::REPL::eval(ENV, incomingCallback);
    print(ENV);
    str result = "";
    list[View] neededViews = [v | <uuid, v> <- myBook, uuid == mid];
    for (View view <- neededViews) {
       RavenNode rendered = render(ENV, machine(mid, "", []), view);
    currentRavenNode = top-down-break visit(currentRavenNode) {
        case ravenTabContainer(list[RavenNode] r) => ravenTabContainer(r + rendered)
    };
    }

    genJSON(currentRavenNode);
    Helpers::Server::send("VIEW_UPDATE:" + readFile(ApplicationConf::JSON_TREE_FILE));
}

