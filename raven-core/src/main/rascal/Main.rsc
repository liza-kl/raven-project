module Main
import IO;
import Location;
import util::Benchmark;
import util::ShellExec;
import ApplicationConf;
import Interpreter::RavenNodes;
import lang::json::IO;
import List;

// https://stackoverflow.com/questions/70324375/changing-the-working-directory-when-using-the-exec-function-in-rascal
void startGodotEngine() {
PID current = createProcess(GODOT_CMD, workingDir=RAVEN_WORK_DIR);
}

public str JSON_CONTENT_START = "{";
public str JSON_CONTENT = "";
public str JSON_CONTENT_END = "}";

void main() {
   RavenNode testNode = ravenNode2D("root", [ravenLabel("ravenLabelID", "actualRavenLabel"), ravenButton("ravenButtonID", "ravenButtonText")]);
    main(testNode);
    str wholeJSONThingy = JSON_CONTENT_START + JSON_CONTENT + JSON_CONTENT_END;
    writeFile(JSON_TREE_FILE, wholeJSONThingy);
}