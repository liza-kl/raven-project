module Main
import Location;
import ApplicationConf;
import util::ShellExec;
import IO;

void main() {
  createProcess("make", workingDir=RAVEN_WORK_DIR, args = ["run.rascal"]);
  println("👋 Booted up, if you want to see the logs, please open up a terminal and 
  type in tmux a -t raven-session");
  println("🔥 To close everything, just type in stop()");
 
}
void stop() {
    exec("make", workingDir=RAVEN_WORK_DIR, args = ["stop"]);
}
