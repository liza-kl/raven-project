module Main
import IO;
import Location;
import util::ShellExec;
import ApplicationConf;
import Interpreter::RavenNode;
import List;
import IO;
import lang::sml::AST;
import Interpreter::JSONMapper;
import Helpers::Server;
import Helpers::Setup;

import util::Eval;
import lang::sml::Command;
import lang::sml::REPL;
import lang::sml::PrettyPrinter;
import lang::sml::Renderer;
import util::Eval;
public str JSON_CONTENT_START = "{";
public str JSON_CONTENT = "";
public str JSON_CONTENT_END = "}";


void rascalCallback(str message) {
    print("printing rascal callback");
    print(message);
}

void rascalCallback2() {
    print("printing rascal callback 2");
}

RavenNode view =
ravenNode2D(
"root",
[ravenLabel("label#1", "My Fancy Editor", 10,30),
 
    ravenGrid("grid#1",
    1,
    2,
    2, 200, 200,
    [ravenButton("button#1", "Decrement Button", "addNode()",100,100),
    ravenButton("button#2", "Increment Button", "inc()",100,100)]),
    ravenTextEdit("testContent", "testCallback"),
    // ravenGraphEditNode("graphNodeEdit", 100, 30, [
    //     ravenGraphNode("graphNode", 100, 40)]),
    ravenNode2D("node2d2", [ravenLabel("label#2", "Another one bytes", 20, 50)])],
true);

/* 
RavenNode view =
ravenNode2D(
"root",
[// add here the generated children <3 ],
true); */


// // This is what should get called from Java? 
// RavenNode() evalCallback(str callback) {
//     // Establish an environment as closure?
//     // The closure function 
//     Env currentEnv = (); // Current AST, but we need current syntac tree 
//     RavenNode updateEnv() {
//     currentEnv = eval(currentEnv, util::Eval::eval(currentEnv, callback)); // the parse command should return a Command from string 
//     return render(currentEnv);
//     }
//     return updateEnv;
// }

// This is what should get called from Java? 
// Env() testClosure(str callback, Env testEnv) {
//     // Establish an environment as closure?
//     // The closure function 
//     Env currentEnv = (); // Current AST, but we need current syntac tree 
//     RavenNode updateEnv() {
//     //currentEnv = eval(currentEnv, util::Eval::eval(currentEnv, callback)); // the parse command should return a Command from string 
//     currentEnv = testEnv;
//    // return currentEnv;
//     }
//     return updateEnv;
// }

void genTree() {
    genJSON(view);
    str jsonString = JSON_CONTENT_START + JSON_CONTENT + JSON_CONTENT_END;
    writeFile(JSON_TREE_FILE, jsonString);
}
public str program =
  "data Command = MachCreate(int mid);
  MachCreate(1);
  // TODO The ; is veeeeery important!
  MachCreate(2);";


void main() {
    Env env = ();
    // Original string with quotes
    // TODO The ; is veeeeery important!
    if(result(Command c) :=  util::Eval::eval(#Command, program))  {
      env = eval(env, c);
    }
    view = render(env);
    println(view);
    startServer();
    startGodotEngine();
    genTree();
    Helpers::Server::send(readFile(JSON_TREE_FILE));
}

