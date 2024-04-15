module Main
import IO;
import Location;
import util::Benchmark;
import util::ShellExec;
import ApplicationConf;
import Client::Client;
import Server::Server;

void listener(LocationChangeEvent event) {
    println(event);
        println("Change triggered from Godot Side");
        println(systemTime());
}

@javaClass{cwi.masterthesis.raven.Teste}
java void testeJava();

// https://stackoverflow.com/questions/70324375/changing-the-working-directory-when-using-the-exec-function-in-rascal
void startGodotEngine() {
PID current = createProcess(GODOT_CMD, workingDir=RAVEN_WORK_DIR);
println(current);
println(readEntireStream(current));
}

void main() {
  //  watch(PROTOCOL_FILE, true,listener);
    testeJava();
    //testServer();
   // testClient();
   // startGodotEngine();
}