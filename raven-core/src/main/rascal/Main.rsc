module Main
import IO;
import Location;
import util::ShellExec;
import ApplicationConf;
import Interpreter::RavenNodes;
import List;
import IO;

public str JSON_CONTENT_START = "{";
public str JSON_CONTENT = "";
public str JSON_CONTENT_END = "}";

// @javaClass{client.RascalClient}
// public java void connect();

// @javaClass{client.RascalClient}
// public java void run();

@javaClass{server.Server}
public java void startServer();

@javaClass{server.Server}
public java void stopServer();

// @javaClass{server.Server}
// public java void connect();


@javaClass{server.Server}
public java void send(str message);



void rascalCallback(str message) {
    print("printing rascal callback");
    print(message);
}

int model = 0;

int getModel() {
    return model;
}
void rascalCallback2() {
    print("printing rascal callback 2");
}

RavenNode getCurrentViewSpec() {
    RavenNode view =
    ravenNode2D(
    "root",
    [ravenLabel("label#1", "My Fancy Editor", 10,30),
        ravenGrid("grid#1",
        1,
        2,
        2, 200, 200,
        [ravenButton("button#1", "Decrement Button", "addNode()"),
        ravenButton("button#2", "Increment Button", "inc()")]),
        // ravenGraphEditNode("graphNodeEdit", 100, 30, [
        //     ravenGraphNode("graphNode", 100, 40)]),
        ravenNode2D("node2d2", [ravenLabel("label#2", "Another one bytes", 20, 50)])],
    true);
    return view;
}

void startGodotEngine() {
PID current = createProcess(GODOT_CMD, workingDir=RAVEN_WORK_DIR);
}

void tree() {
    genJSON(getCurrentViewSpec());
    str jsonString = JSON_CONTENT_START + JSON_CONTENT + JSON_CONTENT_END;
    writeFile(JSON_TREE_FILE, jsonString);
}

void main() {
    startServer();
    startGodotEngine();
}

