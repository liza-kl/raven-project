module lang::sml::control::REPL

import lang::sml::control::ViewCommand;
import lang::sml::control::InputCommand;
import lang::raven::Environment;
import lang::raven::RavenNode;
import lang::Main;
import IO;
import util::Math;
import Map;
import lang::sml::model::Renderer;
import lang::sml::model::Model;
import lang::raven::helpers::Utils;


public Env eval(Env env, Command cmd: ViewTabCreate(UUID vid)) {
    println("Evaluating ViewTabCreate");
    lang::Main::ViewEnv viewEnv = env_retrieve(env, #lang::Main::ViewEnv, 1);
    viewEnv.currentTabs[vid] = lang::sml::model::Renderer::tab(<"New Tab <vid>",
    [
        ravenVBox(
            [
                lang::raven::RavenNode::ravenButton("Delete Tab", "ViewTabDelete(<vid>)"),
                lang::raven::RavenNode::ravenLabel("Select Machine"),
                lang::raven::RavenNode::ravenOptionButton(convertSetToList(domain(env)),
                "ViewTabSetMachine(<vid>,%machine)") 
            ]
        )

        ]>);
    env = env_store(env, 1, view(viewEnv.currentTabs));
    return env;
}

public Env eval(Env env, Command cmd: ViewTabDelete(UUID vid)) {
    lang::Main::ViewEnv viewEnv = env_retrieve(env, #lang::Main::ViewEnv, 1);
    viewEnv.currentTabs = delete(viewEnv.currentTabs, vid);
    env = env_store(env, 1, view(viewEnv.currentTabs));
    return env;
}

public Env eval(Env env, Command cmd: ViewTabSetType(UUID vid)) {
    return env;
}

public Env eval(Env env, Command cmd: ViewTabSetMachine(UUID vid, UUID mid)) {
    ViewEnv viewEnv = env_retrieve(env, #ViewEnv, 1);
    println("view env retrieved");
    ViewMIDMap midVidMappings = env_retrieve(env, #ViewMIDMap, 3);
    println("viewmidmap retrieved");
    midVidMappings.mappings[vid] = mid;
    println("mappings retrieved");

    map[int, Tab] currentTabs = viewEnv.currentTabs; 
    Tab retrievedView = currentTabs[vid];
    Model machine = lang::sml::model::Model::getMach(env,mid);


    RavenNode machineContent = render(env,machine,"tree"); 
    viewEnv.currentTabs[vid].content[1] =viewEnv.currentTabs[vid].content[1] + [machineContent];  
    viewEnv.currentTabs[vid] = lang::sml::model::Renderer::tab(<"Tab <mid>",
    [
        ravenVBox(
            [

                lang::raven::RavenNode::ravenButton("Delete Tab", "ViewTabDelete(<vid>)"),
                lang::raven::RavenNode::ravenLabel("Current Machine: <mid>"),
                lang::raven::RavenNode::ravenLabel("Select New Machine"),
                lang::raven::RavenNode::ravenOptionButton(convertSetToList(domain(env)),
                "ViewTabSetMachine(<vid>,%machine)"),
                ravenLabel("Machine Name"),
                ravenTextEdit(machine.name, "MachSetName(<mid>, %text)"),
                lang::raven::RavenNode::ravenButton("Delete Machine", "MachDelete(<mid>)"),
                lang::raven::RavenNode::ravenButton("Create State", "StateCreate(<nextID(env)>, <mid>)")
            ]
        )

        ] + [machineContent]>); 
    env = env_store(env, 1, view(viewEnv.currentTabs));
    env = env_store(env, 3, viewMID(midVidMappings.mappings));
    return env;
}

// INPUT REPL
public Env eval(Env env, lang::sml::control::InputCommand::Command cmd: InputCreate(value input)) {
    InputEnv inputEnv = env_retrieve(env, #InputEnv, 2);
    inputEnv.stagedValues =  inputEnv.stagedValues + input;
    return env;
}

public Env eval(Env env, lang::sml::control::InputCommand::Command cmd: InputClear()) {
    InputEnv inputEnv = env_retrieve(env, #InputEnv, 2);
    inputEnv.stagedValues = [];
    return env;
}

public list[value] eval(Env env, lang::sml::control::InputCommand::Command cmd: InputRetrieve()) {
    InputEnv inputEnv = env_retrieve(env, #InputEnv, 2);
    println(inputEnv.stagedValues);
    return inputEnv.stagedValues;
}