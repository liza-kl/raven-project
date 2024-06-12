module lang::sml::runtime::RuntimeCallbacks
import lang::sml::runtime::Command;
import lang::sml::runtime::Model;
import lang::sml::runtime::REPL;
import lang::sml::model::Model;
import lang::raven::Environment;
import lang::raven::RavenNode;
import lang::sml::model::Renderer;
import lang::sml::runtime::RuntimeRenderer;
import IO;
import lang::raven::JSONMapper;
import lang::raven::helpers::Server;
import lang::sml::control::REPL;
import ApplicationConf;
import lang::Main;
import lang::sml::control::ViewCommand;
import lang::sml::control::ViewCallbacks;
import util::UUID;
// IMP
public void runtimeControl(Command incomingCallback: MachInstCreate(UUID miid, UUID mid)) {
    IO::println("Calling MachInstCreate");
    env = eval(env, MachInstCreate(miid, mid));
    UUID vid = uuidi();
    lang::Main::ViewTypeMap viewID2TabType = env_retrieve(env, #ViewTypeMap, 5);
    lang::Main::ViewEnv viewEnv = env_retrieve(env, #lang::Main::ViewEnv, 1);

    CurrentPossibleTriggers currentPossibleTriggersEnv = env_retrieve(env, #CurrentPossibleTriggers, 6);

    // TODO fix the mappings.   
    currentPossibleTriggersEnv.mappings[miid] =  [trigger | t <- env, trans(_,sid,trigger,_) := env[t]];

    env = env_store(env, 6, currentPossibleTriggers(currentPossibleTriggersEnv.mappings));

    viewID2TabType.mappings[vid] = "runtime-1"; 
    env = env_store(env, 5, vidType(viewID2TabType.mappings));
    viewEnv.currentTabs[vid] = lang::sml::model::Renderer::tab(<"Runtime-1 for <mid>",
    [
        lang::sml::runtime::RuntimeRenderer::render(env, env[miid], "runtime-1")
        ]>);
    env = env_store(env, 1, view(viewEnv.currentTabs));
    lang::raven::JSONMapper::genJSON(render(env));
    lang::raven::helpers::Server::send("VIEW_UPDATE:" + readFile(ApplicationConf::JSON_TREE_FILE));
}



// IMP
public void runtimeControl(Command incomingCallback: MachInstIntermTrigger(UUID miid, int idx)) {
    IO::println("Calling MachInstIntermTrigger");
    env = lang::sml::runtime::REPL::eval(env, MachInstIntermTrigger(miid, idx));
    lang::raven::JSONMapper::genJSON(render(env));
    lang::raven::helpers::Server::send("VIEW_UPDATE:" + readFile(ApplicationConf::JSON_TREE_FILE));
}



// IMP
public void runtimeControl(Command incomingCallback: MachInstDelete(UUID miid, UUID mid)) {
    IO::println("Calling MachInstDelete");
    lang::Main::env = eval(env, MachInstDelete(miid, mid));
    lang::raven::JSONMapper::genJSON(render(env));
    lang::raven::helpers::Server::send("VIEW_UPDATE:" + readFile(ApplicationConf::JSON_TREE_FILE));
}

// IMP
public void runtimeControl( Command incomingCallback: MachInstTrigger(UUID miid, str trigger)) {
    IO::println("Calling MachInstTrigger");
    lang::Main::env = eval(env, MachInstTrigger(miid, trigger));
    lang::raven::JSONMapper::genJSON(render(env));
    lang::raven::helpers::Server::send("VIEW_UPDATE:" + readFile(ApplicationConf::JSON_TREE_FILE));
}
