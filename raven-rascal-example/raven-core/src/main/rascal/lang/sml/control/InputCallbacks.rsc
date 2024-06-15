module lang::sml::control::InputCallbacks
import IO;
import lang::Main;
import lang::raven::helpers::Server;
import lang::sml::control::InputCommand;
import lang::sml::control::REPL;
import ApplicationConf;

public void inputControl(Command incomingCallback: InputCreate(value val)) {
    IO::println("Calling InputCreate");
    lang::Main::env = lang::sml::control::REPL::eval(lang::Main::env, InputCreate(val));
    lang::raven::helpers::Server::send("VIEW_UPDATE:" + readFile(ApplicationConf::JSON_TREE_FILE));
}

public void inputControl(Command incomingCallback: InputClear()) {
    IO::println("Calling InputDelete");
    lang::Main::env = lang::sml::control::REPL::eval(lang::Main::env, InputClear());
    lang::raven::helpers::Server::send("VIEW_UPDATE:" + readFile(ApplicationConf::JSON_TREE_FILE));
}
