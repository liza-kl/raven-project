module Main
import IO;
import Location;
import ApplicationConf;
import List;
import lang::Main;
import lang::raven::JSONMapper;
import lang::raven::helpers::Server;
import lang::raven::RavenNode;
import lang::sml::model::Renderer;
import util::ShellExec;
import IO;
void main(/* Env env, RavenNode(Env env) renderFunction */) {
  RavenNode view = lang::sml::model::Renderer::render(env);
  lang::raven::JSONMapper::genJSON(view);
  createProcess("make", workingDir=RAVEN_WORK_DIR, args = ["run"]);

  println("👋 Booted up, if you want to see the logs, please open up a terminal and 
  type in tmux a -t raven-session");
  println("🔥 To close everything, just type in stop()");
  // TODO block somehow until server is there.
 // init();

}

void init() {
 // lang::raven::helpers::Server::send("THEME_INIT:" + readFile(JSON_STYLING_FILE));
  lang::raven::helpers::Server::send("VIEW_UPDATE:" + readFile(JSON_TREE_FILE));
}
void stop() {
    exec("make", workingDir=RAVEN_WORK_DIR, args = ["stop"]);
}
