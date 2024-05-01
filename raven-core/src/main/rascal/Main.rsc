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
public java void getInstance();

@javaClass{server.Server}
public java void stopServer();

// @javaClass{server.Server}
// public java void connect();

@javaClass{server.Server}
public java value getCurrentState();

@javaClass{server.Server}
public java value getBuffer();

@javaClass{server.Server}
public java void send(str message);


void rascalCallback(str message) {
    print("printing rascal callback");
    print(message);
}

void rascalCallback2() {
    print("printing rascal callback 2");
}

RavenNode getCurrentViewSpec() {
    RavenNode view =
    ravenNode2D(
    "root",
    [ravenLabel("label#1", "My Counter Application", 10,30),
        ravenButton("button#1", "Decrement Button", "dec()", -100,20),
        ravenButton("button#2", "Increment Button", "inc()", 100,20)],
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
    tree();
   // getInstance();
    startServer();
    startGodotEngine();
    print(getCurrentState());
}

