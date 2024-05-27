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

 
import lang::sml::REPL;
import lang::sml::PrettyPrinter;
import lang::sml::Renderer;
import util::Eval;

extend lang::sml::Command;
public str JSON_CONTENT_START = "{";
public str JSON_CONTENT = "";
public str JSON_CONTENT_END = "}";

public Env env = (2:machine(2,"",[]));
public str program =
  "alias UUID = int;
  data Command = MachCreate(int mid)
   | StateDelete(UUID sid);
  ";

void rascalCallback(str callback) {
    if(result(Command c) :=  util::Eval::eval(#Command, program + callback + ";"))  {
        env = lang::sml::REPL::eval(env, c);
        updatedView = render(env);
        println(updatedView);
        genTree(updatedView); 
        Helpers::Server::send("VIEW_UPDATE:" + readFile(JSON_TREE_FILE));
    }
    
}

void genTree(RavenNode view) {
    genJSON(view);
    str jsonString = JSON_CONTENT_START + JSON_CONTENT + JSON_CONTENT_END;
    writeFile(JSON_TREE_FILE, jsonString);
}


void main() {
    // Original string with quotes
    // TODO The ; is veeeeery important!
    if(result(Command c) :=  util::Eval::eval(#Command, program))  {
      env = lang::sml::REPL::eval(env, c);
    }
    RavenNode view = render(env);
    startGodotEngine();
    startServer();
    genTree(view);
    Helpers::Server::send("THEME_INIT:" + readFile(JSON_STYLING_FILE));
    Helpers::Server::send("VIEW_UPDATE:" + readFile(JSON_TREE_FILE));
}

