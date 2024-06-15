module lang::sml::control::ViewCallbacks

import IO;
import Type;
import ApplicationConf;
import lang::raven::helpers::Server;
import lang::Main;
import lang::raven::Environment;
import lang::raven::JSONMapper;
import lang::sml::model::Renderer;
import lang::sml::control::ViewCommand;
import lang::sml::control::REPL;

public void viewControl(Command incomingCallback: ViewTabCreate(UUID vid)) {
    IO::println("Calling ViewTabCreate");
    lang::Main::env = lang::sml::control::REPL::eval(lang::Main::env, ViewTabCreate(vid));
    // Default are tree views.
    lang::Main::env = lang::sml::control::REPL::eval(lang::Main::env, ViewTabSetType(vid, "tree"));
    lang::raven::JSONMapper::genJSON(render(env));
    lang::raven::helpers::Server::send("VIEW_UPDATE:" + readFile(ApplicationConf::JSON_TREE_FILE));
}

// public void viewControl(Command incomingCallback: ViewTabCreate(UUID vid, str name, int mid, str viewType, RavenNode content)) {
//     IO::println("Calling ViewTabCreate");
//     lang::Main::env = lang::sml::control::REPL::eval(lang::Main::env, 
//                                                     ViewTabCreate(vid, name, mid, viewType, content));
//     lang::raven::helpers::Server::send("VIEW_UPDATE:" + readFile(ApplicationConf::JSON_TREE_FILE));
// }


public void viewControl(Command incomingCallback: ViewTabDelete(UUID vid)) {
    IO::println("Calling ViewTabDelete");
    lang::Main::env = lang::sml::control::REPL::eval(lang::Main::env, ViewTabDelete(vid));
    genJSON(lang::sml::model::Renderer::render(env));    
    lang::raven::helpers::Server::send("VIEW_UPDATE:" + readFile(ApplicationConf::JSON_TREE_FILE));
}

public void viewControl(Command incomingCallback: ViewTabSetType(UUID vid, str viewType)) {
    IO::println("Calling ViewTabSetType");
    lang::Main::env = lang::sml::control::REPL::eval(lang::Main::env, ViewTabSetType(vid, viewType));
    println("current env in viewtabsettype");
    println(env);
    genJSON(lang::sml::model::Renderer::render(env));   
    lang::raven::helpers::Server::send("VIEW_UPDATE:" + readFile(ApplicationConf::JSON_TREE_FILE));
}

public void viewControl(Command incomingCallback: ViewTabSetMachine(UUID vid, UUID mid)) {
    IO::println("Calling ViewTabSetMachine");
    lang::Main::env = lang::sml::control::REPL::eval(lang::Main::env, ViewTabSetMachine(vid,mid));
    genJSON(lang::sml::model::Renderer::render(env));     
    lang::raven::helpers::Server::send("VIEW_UPDATE:" + readFile(ApplicationConf::JSON_TREE_FILE));
}

public void viewControl(Command incomingCallback: ViewTabSetMachineInstance(UUID vid, UUID miid)) {
    IO::println("Calling ViewTabSetMachineInstance");
    lang::Main::env = lang::sml::control::REPL::eval(lang::Main::env, ViewTabSetMachineInstance(vid,miid));
    genJSON(lang::sml::model::Renderer::render(env));     
    lang::raven::helpers::Server::send("VIEW_UPDATE:" + readFile(ApplicationConf::JSON_TREE_FILE));
}

public default void viewControl(Command incomingCallback) { 
    throw "No Control function callback of type <Type::typeOf(incomingCallback)>"; } 
