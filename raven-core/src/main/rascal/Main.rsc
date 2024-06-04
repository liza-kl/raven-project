module Main
import IO;
import Location;
import ApplicationConf;
import Interpreter::RavenNode;
import List;
import lang::sml::AST;
import Interpreter::JSONMapper;
import lang::raven::helpers::Server;
import util::Reflective;
import lang::sml::model::Renderer;
import util::ShellExec;
import lang::raven::helpers::Setup;

// TODO or render function?
void main(/* Env env, RavenNode initialView */) {
  //  RavenNode view = lang::sml::model::Renderer::render(env);
   // createProcess("make run", workingDir=RAVEN_WORK_DIR);
 //  startServer();
 //  startGodotEngine();

   // lang::raven::helpers::Server::send("THEME_INIT:" + readFile(JSON_STYLING_FILE));
  //  genJSON(view);
    lang::raven::helpers::Server::send("VIEW_UPDATE:" + readFile(JSON_TREE_FILE));
}

void stop() {
    createProcess("make stop", workingDir=RAVEN_WORK_DIR);
}