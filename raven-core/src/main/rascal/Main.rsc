module Main
import IO;
import Location;
import util::ShellExec;
import ApplicationConf;
import Interpreter::RavenNodes;
import List;
import IO;




// https://stackoverflow.com/questions/70324375/changing-the-working-directory-when-using-the-exec-function-in-rascal
void startGodotEngine() {
PID current = createProcess(GODOT_CMD, workingDir=RAVEN_WORK_DIR);
}

public str JSON_CONTENT_START = "{";
public str JSON_CONTENT = "";
public str JSON_CONTENT_END = "}";

@javaClass{server.Server}
public java void startServer();

@javaClass{server.Server}
public java void send(str message);

void printsomething() {
    print("a print something");
}

void main() {
   RavenNode view =
    ravenNode2D(
    "root",
    [ravenLabel("label#1", "My Counter Application", 10,30),
        ravenButton("button#1", "Decrement Button", "dec()", -100,20),
        ravenButton("button#2", "Increment Button", "inc()", 100,20)],
    true);
    startServer();
    // main(view);
    // str wholeJSONThingy = JSON_CONTENT_START + JSON_CONTENT + JSON_CONTENT_END;
    // writeFile(JSON_TREE_FILE, wholeJSONThingy);
}