module Main
import IO;
import Location;
import ApplicationConf;
import Interpreter::RavenNode;
import List;
import lang::sml::AST;
import Interpreter::JSONMapper;
import Helpers::Server;
import Helpers::Setup;
import util::Reflective;
import Location;
import lang::sml::PrettyPrinter;
import lang::sml::model::Renderer;
import lang::sml::control::REPL;
import lang::sml::model::Command;
import ValueIO;

public str JSON_CONTENT_START = "{";
public str JSON_CONTENT = "";
public str JSON_CONTENT_END = "}";

/* TODO add different languages and prepend with languages VIEW_addTab, PROGRAM_updateEnv */ 
void dispatch(str callback) {
    //todo name collisions; 
    print("dispatching callback");
   // if(result(Command c) := util::Eval::eval(#Command, [program + callback + ";"]))  {
        lang::sml::control::REPL::viewControl(ValueIO::readTextValueString(#Command, callback));
   // }

    
}

void genTree(RavenNode view) {
    genJSON(view);
    str jsonString = JSON_CONTENT_START + JSON_CONTENT + JSON_CONTENT_END;
    JSON_CONTENT = ""; // Resetting
    writeFile(JSON_TREE_FILE, jsonString);
}


void main() {
 // println(readTextValueString(#Command, "MachCreate(3)"));
    // Original string with quotes
    // TODO The ; is veeeeery important!
    // if(result(Command c) :=  util::Eval::eval(#Command, program))  {
    //   ENV = lang::sml::REPL::eval(ENV, c);
    // }
    // RavenNode view = render(ENV);
    // startGodotEngine();
    // startServer();
    // genTree(view);
    // Helpers::Server::send("THEME_INIT:" + readFile(JSON_STYLING_FILE));
    genJSON(appendTabContainer(render(ENV)));
    Helpers::Server::send("VIEW_UPDATE:" + readFile(JSON_TREE_FILE));
}

