module Closure
import IO;
import ParseTree;
import lang::sml::Syntax;
import lang::sml::Renderer;
import lang::sml::REPL;
import lang::sml::Command;
import util::Eval;
// Define a function that returns a closure
int(int) adder(int x) {
    str bido ="bido";
    int add(int y) {
        println(bido);
        return x + y;
    }
    return add;
}

// Function to evaluate a Rascal expression represented as a string
value evaluateRascalExpression(str expr) {
    return parse(#Element, expr); // Parse the string as a Rascal expression
}
// Run this before starting and generate the raven nodes. 
public str program =
  "data Command = MachCreate(int mid);
  MachCreate(1);
  // TODO The ; is veeeeery important!
  MachCreate(2);";

// Example usage
void main() {
    Env env = ();
    // Original string with quotes
    // TODO The ; is veeeeery important!
    if(result(Command c) :=  util::Eval::eval(#Command, program))  {
      env = eval(env, c);
    }
    println(render(env));

}

