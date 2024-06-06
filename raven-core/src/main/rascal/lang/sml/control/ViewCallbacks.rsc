module lang::sml::control::ViewCallbacks

import IO;
import Type;
import ApplicationConf;
import lang::raven::helpers::Server;
import lang::Main;

import lang::raven::Environment;
import lang::sml::control::ViewCommand;
import lang::sml::control::REPL;

public void viewControl(Command incomingCallback: ViewTabCreate(UUID vid)) {
    IO::println("Calling ViewTabCreate");
    lang::Main::env = lang::sml::control::REPL::eval(lang::Main::env, ViewTabCreate(vid));
    lang::raven::helpers::Server::send("VIEW_UPDATE:" + readFile(ApplicationConf::JSON_TREE_FILE));
}

public void viewControl(Command incomingCallback: ViewTabDelete(UUID vid)) {
    IO::println("Calling ViewTabDelete");
    lang::Main::env = lang::sml::control::REPL::eval(lang::Main::env, ViewTabDelete(vid));
    lang::raven::helpers::Server::send("VIEW_UPDATE:" + readFile(ApplicationConf::JSON_TREE_FILE));
}

public void viewControl(Command incomingCallback: ViewTabSetType(UUID vid)) {
    IO::println("Calling ViewTabSetType");
    lang::Main::env = lang::sml::control::REPL::eval(lang::Main::env, ViewTabSetType(vid));
    lang::raven::helpers::Server::send("VIEW_UPDATE:" + readFile(ApplicationConf::JSON_TREE_FILE));
}

public void viewControl(Command incomingCallback: ViewTabSetMachine(UUID vid, UUID mid)) {
    IO::println("Calling ViewTabSetMachine");
    lang::Main::env = lang::sml::control::REPL::eval(lang::Main::env, ViewTabSetMachine(vid,mid));
    lang::raven::helpers::Server::send("VIEW_UPDATE:" + readFile(ApplicationConf::JSON_TREE_FILE));
}

public default void viewControl(Command incomingCallback) { 
    throw "No Control function callback of type <Type::typeOf(incomingCallback)>"; } 
