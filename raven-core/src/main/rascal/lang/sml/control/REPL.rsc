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
import List;
import Set;
import Map;


public Env eval(Env env, Command cmd: ViewTabCreate(UUID vid)) {
    println("Evaluating ViewTabCreate");
    lang::Main::ViewTypeMap viewID2TabType = env_retrieve(env, #ViewTypeMap, 5);
    lang::Main::ViewEnv viewEnv = env_retrieve(env, #lang::Main::ViewEnv, 1);
    // The Default view of a machine when rendered.
    viewID2TabType.mappings[vid] = "tree"; 
    env = env_store(env, 5, vidType(viewID2TabType.mappings));
    // The Default Screen appearing when opening a new tab.
    viewEnv.currentTabs[vid] = lang::sml::model::Renderer::tab(<"New Tab <vid>",
    [
        ravenVBox(
            [
                lang::raven::RavenNode::ravenButton("Delete Tab", "ViewTabDelete(<vid>)"),
                lang::raven::RavenNode::ravenLabel("Select Machine"),
                lang::raven::RavenNode::ravenOptionButton(
                    [toString(mid) | elem <- env, mach( mid,_,_,_) := env[elem]],
                    "ViewTabSetMachine(<vid>,%machine)",
                    [setting("Primitive", [<"selected", "Int%<-1>">])]) 
            ]
        )
        ]>);
    env = env_store(env, 1, view(viewEnv.currentTabs));
    return env;
}

/* 
* ViewTabDelete does not delete the machine definition per se
* For that MachDelete needs to be called
*/ 
public Env eval(Env env, Command cmd: ViewTabDelete(UUID vid)) {
    lang::Main::ViewEnv viewEnv = env_retrieve(env, #lang::Main::ViewEnv, 1);
    // Removing only the view part
    viewEnv.currentTabs = delete(viewEnv.currentTabs, vid);
    // Removing the mapping part.
    ViewMIDMap viewMID2 = env_retrieve(env, #ViewMIDMap, 3);

    for (v <- viewMID2.mappings ) {
       if(vid == v) {
       viewMID2.mappings = delete(viewMID2.mappings, vid); 
       }
    }
    env = env_store(env, 3, viewMID(viewMID2.mappings));
    env = env_store(env, 1, view(viewEnv.currentTabs));
    return env;
}

public Env eval(Env env, Command cmd: ViewTabSetType(UUID vid, str viewType)) {
    // TODO: Fix the update / render if machine is already set.
    IO::println("Evaluating ViewTabSetType");
    ViewTypeMap midVidMappings = env_retrieve(env, #ViewTypeMap, 5);
    midVidMappings.mappings[vid] = viewType; 
    env = env_store(env, 5, vidType(midVidMappings.mappings));
    /* Checking this case to determine if we set the default type for a new tab
    or if we already have a machine. */ 

    ViewMIDMap vidMid= env_retrieve(env, #ViewMIDMap, 3);
    if (vid in domain(vidMid.mappings)) {
    int mid = env_retrieveMIDfromVID(vid);
    env = eval(env,ViewTabSetMachine(vid, mid));
    }
    return env;
}

public Env eval(Env env, Command cmd: ViewTabSetMachine(UUID vid, UUID mid)) {
    ViewEnv viewEnv = env_retrieve(env, #ViewEnv, 1);
    ViewTypeMap vidType = env_retrieve(env, #ViewTypeMap, 5);
    ViewMIDMap midVidMappings = env_retrieve(env, #ViewMIDMap, 3);
    midVidMappings.mappings[vid] = mid;

    map[int, Tab] currentTabs = viewEnv.currentTabs; 
    Tab retrievedView = currentTabs[vid];
    Model machine = lang::sml::model::Model::getMach(env,mid);

    // The last param is retrieving the view --> either "tree" or "table"
    println("type to be rendered");
    println(vidType.mappings[vid]);
    RavenNode machineContent = render(env,machine,vidType.mappings[vid]); 
    println("machine content ");
    println(machineContent);
    viewEnv.currentTabs[vid] = lang::sml::model::Renderer::tab(<"Tab <vid>",
    [
        ravenVBox(
            [

                lang::raven::RavenNode::ravenButton("Delete Tab", "ViewTabDelete(<vid>)"),
                lang::raven::RavenNode::ravenLabel("Current Machine: <mid>"),
                lang::raven::RavenNode::ravenLabel("Select New Machine"),
                lang::raven::RavenNode::ravenOptionButton(
                [toString(mid2) |  elem <- env, mach( mid2, _, _, _) := env[elem]],
                "ViewTabSetMachine(<vid>,%machine)",
                [setting("Primitive", [<"selected", "Int%<List::indexOf([mid2 | elem <- env,mach( mid2, _, _, _) := env[elem]],mid)>">])]),
                ravenLabel("Machine Name"),
                ravenTextEdit(machine.name, "MachSetName(<mid>, %text)"),
                lang::raven::RavenNode::ravenButton("Delete Machine", "MachDelete(<mid>)"),
                lang::raven::RavenNode::ravenButton("Create State", "StateCreate(<nextID(env)>, <mid>)"),
                lang::raven::RavenNode::ravenOptionButton(["tree","table"],
                "ViewTabSetType(<vid>,%type)",
                [setting("Primitive", [<"selected", "Int%<List::indexOf(["tree","table"], vidType.mappings[vid])>">])])   
            ]
        )

        ] + [machineContent]>); 
    println("current tab content");
    println(viewEnv.currentTabs[vid]);
    env = env_store(env, 1, view(viewEnv.currentTabs));
    env = env_store(env, 3, viewMID(midVidMappings.mappings));

    println("current env");
    println(env); 
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

