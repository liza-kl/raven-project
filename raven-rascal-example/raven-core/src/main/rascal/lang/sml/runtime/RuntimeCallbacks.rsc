module lang::sml::runtime::RuntimeCallbacks
import lang::sml::runtime::Command;
import lang::sml::runtime::Model;
import lang::sml::runtime::REPL;
import lang::sml::model::Model;
import lang::raven::Environment;
import lang::raven::RavenNode;
import lang::sml::model::Renderer;
import IO;
import lang::raven::JSONMapper;
import lang::raven::helpers::Server;
import lang::sml::control::REPL;
import ApplicationConf;
import lang::Main;
import lang::sml::control::ViewCommand;
import lang::sml::control::ViewCallbacks;
import util::UUID;
import lang::sml::runtime::RuntimeRenderer;
// IMP
public void runtimeControl(Command incomingCallback: MachInstCreate(UUID miid, UUID mid)) {
   // IO::println("Calling MachInstCreate");
    env = eval(env, MachInstCreate(miid, mid));
    ViewMIDMap viewMID2 = env_retrieve(env, #ViewMIDMap, 3);
    vid2 = uuidi();
    viewMID2.mappings[vid2] = miid;
    env = env_store(env, 3, viewMID(viewMID2.mappings));

    

    list[int] machToUpdate = [miid2 | elem <- env, machInst(miid2,_,_,_) := env[elem]];
    for (machID <- machToUpdate) {
        list[int] vid = env_retrieveVIDfromMID(machID);
        for (int v <- vid) {
        lang::Main::env = eval(env,ViewTabSetMachineInstance(v, machID));
        }
    }

    // UUID vid = uuidi();
    // ViewMIDMap viewMIDEnv = env_retrieve(env, #ViewMIDMap, 3);
    // viewMIDEnv.mappings[vid] = miid;
    // env = env_store(env, 3, viewMID(viewMIDEnv.mappings));
    // lang::Main::ViewTypeMap viewID2TabType = env_retrieve(env, #ViewTypeMap, 5);
    // lang::Main::ViewEnv viewEnv = env_retrieve(env, #lang::Main::ViewEnv, 1);

    // CurrentPossibleTriggers currentPossibleTriggersEnv = env_retrieve(env, #CurrentPossibleTriggers, 6);

    // // TODO fix the mappings.   
    // currentPossibleTriggersEnv.mappings[miid] =  [trigger | t <- env, trans(_,sid,trigger,_) := env[t]];

    // env = env_store(env, 6, currentPossibleTriggers(currentPossibleTriggersEnv.mappings));

    // viewID2TabType.mappings[vid] = "runtime-1"; 
    // env = env_store(env, 5, vidType(viewID2TabType.mappings));




    // env = env_store(env, 1, view(viewEnv.currentTabs));
    lang::raven::JSONMapper::genJSON(render(env));
    lang::raven::helpers::Server::send("VIEW_UPDATE:" + readFile(ApplicationConf::JSON_TREE_FILE));
}



// IMP
public void runtimeControl(Command incomingCallback: MachInstDelete(UUID miid, UUID mid)) {
    //IO::println("Calling MachInstDelete");
    list[int] vid = env_retrieveVIDfromMID(miid);
    for (int v <- vid) {
    env = lang::sml::control::REPL::eval(lang::Main::env, ViewTabDelete(v));
    }
    env = eval(env, MachInstDelete(miid, mid));
    lang::raven::JSONMapper::genJSON(render(env));
    lang::raven::helpers::Server::send("VIEW_UPDATE:" + readFile(ApplicationConf::JSON_TREE_FILE));
}

// IMP
public void runtimeControl(Command incomingCallback: MachInstTrigger(UUID miid, str trigger)) {
   // IO::println("Calling MachInstTrigger");
    env = eval(env, MachInstTrigger(miid, trigger));

    list[int] vid = env_retrieveVIDfromMID(miid);
    for (int v <- vid) {
    env = eval(env,ViewTabSetMachineInstance(v, miid));
    }
    lang::raven::JSONMapper::genJSON(render(env));
    lang::raven::helpers::Server::send("VIEW_UPDATE:" + readFile(ApplicationConf::JSON_TREE_FILE));
}
