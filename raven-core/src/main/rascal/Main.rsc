module Main
import IO;
import Location;
import util::Benchmark;
import util::ShellExec;
import ApplicationConf;
import Interpreter::RavenNodes;
import lang::json::IO;
import List;

void listener(LocationChangeEvent event) {
    println(event);
        println("Change triggered from Godot Side");
        println(systemTime());
}

// https://stackoverflow.com/questions/70324375/changing-the-working-directory-when-using-the-exec-function-in-rascal
void startGodotEngine() {
PID current = createProcess(GODOT_CMD, workingDir=RAVEN_WORK_DIR);
//println(current);
//println(readEntireStream(current));
}
public str JSON_CONTENT_START = "{";
public str JSON_CONTENT = "";
public str JSON_CONTENT_END = "}";

void main() {
 // Creating a RavenNode using the ravenLabel constructor
   RavenNode testNode = ravenNode2D("root", [ravenLabel("ravenLabelID", "actualRavenLabel"), ravenButton("ravenButtonID", "ravenButtonText")]);
  //  RavenNode testNode = ravenNode2D(ravenNode2D("root", []));
    traverseTreeRecursively(testNode);
    
    str wholeJSONThingy = JSON_CONTENT_START + JSON_CONTENT + JSON_CONTENT_END;
    writeFile(JSON_TREE_FILE, wholeJSONThingy);
}