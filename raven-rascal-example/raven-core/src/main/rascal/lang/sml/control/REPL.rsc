module lang::sml::control::REPL

import lang::sml::control::ViewCommand;
import lang::sml::control::InputCommand;
import lang::sml::Environment;
import lang::raven::RavenNode;
import lang::sml::runtime::RuntimeRenderer;
import lang::Main;
import IO;
import util::Math;
import Map;
import lang::sml::model::Renderer;
import lang::sml::model::Model;
import lang::sml::runtime::Model;
import List;
import Set;
import Map;
import lang::sml::model::Styles;

// TODO Make more generic because of runtime stuff? 
public Env eval(Env env, Command cmd: ViewTabCreate(UUID vid)) {
  //  println("Evaluating ViewTabCreate");
    lang::Main::ViewTypeMap viewID2TabType = env_retrieve(env, #ViewTypeMap, 5);
    lang::Main::ViewEnv viewEnv = env_retrieve(env, #lang::Main::ViewEnv, 1);
    // The Default view of a machine when rendered.
    viewID2TabType.mappings[vid] = "tree"; 
    env = env_store(env, 5, vidType(viewID2TabType.mappings));
    // The Default Screen appearing when opening a new tab.
    viewEnv.currentTabs[vid] = lang::sml::model::Renderer::tab(<"New Tab",
    [
        
        ravenVBox(
            [
                ravenLabel("General Actions", settings=h2FontSize),
                ravenButton("Delete Tab", "ViewTabDelete(<vid>)", settings=buttonDanger),
                ravenLabel("Select Machine", settings=h2FontSize),
                ravenOptionButton(
                    [toString(mid) | elem <- env, mach( mid,_,_,_) := env[elem]],
                    "ViewTabSetMachine(<vid>,%machine)",
                    settings= optionButtonSettings + [setting("Primitive", [<"selected", "Int%<-1>">])]) 
            ]
        , settings=vboxContainerStyles)
        ]>);
    env = env_store(env, 1, view(viewEnv.currentTabs));
    return env;
}

public Env eval(Env env, Command cmd: ViewTabCreate(UUID vid)) {
   // println("Evaluating ViewTabCreate");
    lang::Main::ViewTypeMap viewID2TabType = env_retrieve(env, #ViewTypeMap, 5);
    lang::Main::ViewEnv viewEnv = env_retrieve(env, #lang::Main::ViewEnv, 1);
    // The Default view of a machine when rendered.
    viewID2TabType.mappings[vid] = "runtime-1"; 
    env = env_store(env, 5, vidType(viewID2TabType.mappings));
    // The Default Screen appearing when opening a new tab.
    viewEnv.currentTabs[vid] = lang::sml::model::Renderer::tab(<"New Tab",
    [
        
        ravenVBox(
            [
                ravenLabel("General Actions", settings=h2FontSize),
                lang::raven::RavenNode::ravenButton("Delete Tab", "ViewTabDelete(<vid>)", settings=buttonDanger),
                lang::raven::RavenNode::ravenLabel("Select Machine",settings=h2FontSize),
                lang::raven::RavenNode::ravenOptionButton(
                    [toString(mid) | elem <- env, mach( mid,_,_,_) := env[elem]],
                    "ViewTabSetMachine(<vid>,%machine)",
                    settings= optionButtonSettings + [setting("Primitive", [<"selected", "Int%<-1>">])]) 
            ]
        , settings=vboxContainerStyles)
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
   // IO::println("Evaluating ViewTabSetType");
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
    Model machine = lang::sml::model::Model::getMach(env,mid);
    RavenNode machineContent = render(env,machine,vidType.mappings[vid]); 
    viewEnv.currentTabs[vid] = lang::sml::model::Renderer::tab(<"<machine.name> Editor Tab <mid>",
    [
        ravenMarginContainer([
        ravenVBox(
            [
                ravenLabel("General Actions", settings=h2FontSize),
                ravenButton("Delete Tab", "ViewTabDelete(<vid>)", settings=buttonDanger),
                ravenHBox([
                ravenLabel("Current Machine", settings=bodyFontSize + hboxContainerHorizontalExpand),
                ravenOptionButton(
                [toString(mid2) |  elem <- env, mach( mid2, _, _, _) := env[elem]],
                "ViewTabSetMachine(<vid>,%machine)",
                settings=hboxContainerHorizontalExpand +optionButtonSettings + [setting("Primitive", [<"selected", "Int%<List::indexOf([mid2 | elem <- env,mach( mid2, _, _, _) := env[elem]],mid)>">])]),
                ravenButton("Delete Machine", "MachDelete(<mid>)", settings=hboxContainerHorizontalExpand +buttonDanger)
                ], settings=hboxContainerHorizontalExpand),
                ravenHBox([
              //  ravenLabel("Machine Name", settings=bodyFontSize + hboxContainerHorizontalExpand)
                // ravenTextEdit(machine.name, "MachSetName(<mid>, %text)", settings=textEditSettings +hboxContainerHorizontalExpand)
                ], settings=hboxContainerHorizontalExpand), 
                
               // lang::raven::RavenNode::ravenButton("Create State", "StateCreate(<nextID(env)>, <mid>)", settings=buttonCreate),
                lang::raven::RavenNode::ravenButton("Run Instance of this Machine", "MachInstCreate(<nextID(env)>,<mid>)", settings=buttonCreate),
                ravenMarginContainer([
                ravenLabel("Available Editors", settings=h2FontSize)], settings=marginContainer5),
                lang::raven::RavenNode::ravenOptionButton(["tree","table"],
                "ViewTabSetType(<vid>,%type)",
                settings=optionButtonSettings + [setting("Primitive", [<"selected", "Int%<List::indexOf(["tree","table"], vidType.mappings[vid])>">])])   
            ]
        , settings=vboxContainerStyles)], settings=marginContainerEven)

        ]  + [machineContent]>); 
    env = env_store(env, 1, view(viewEnv.currentTabs));
    env = env_store(env, 3, viewMID(midVidMappings.mappings));
    return env;
}



public Env eval(Env env, Command cmd: ViewTabSetCurrentTab(UUID tabID)) {
   // println("Evaluating ViewTabSetCurrentTab(UUID vid, UUID miid)");
    env = env_store(env,4,currentTab(tabID));
    return env;
}
public Env eval(Env env, Command cmd: ViewTabSetMachineInstance(UUID vid, UUID miid)) {
 //   println("Evaluating ViewTabSetMachineInstance(UUID vid, UUID miid)");
    ViewEnv viewEnv = env_retrieve(env, #ViewEnv, 1);
    ViewTypeMap vidType = env_retrieve(env, #ViewTypeMap, 5);
    ViewMIDMap midVidMappings = env_retrieve(env, #ViewMIDMap, 3);

    Model machineInstance = lang::sml::runtime::Model::getMachInst(env,miid);

    midVidMappings.mappings[vid] = miid;
    map[int, Tab] currentTabs = viewEnv.currentTabs;  

    RavenNode machineContent = render(env,machineInstance, "runtime-1"); 
    viewEnv.currentTabs[vid] = lang::sml::model::Renderer::tab(<"Runtime Tab <miid>",
    [
        
        ravenVBox(
            [
            ravenLabel("General Actions", settings=h2FontSize),
            ravenLabel("Running Machine Instance <miid>", settings=h2FontSize),
           // ravenButton("Delete Tab", "ViewTabDelete(<vid>)",settings=buttonDanger),
            ravenButton("Kill Instance", "MachInstDelete(<miid>,<machineInstance.mid>)", settings=buttonDanger)]
            )
    ] + 
    [machineContent]>); 
    env = env_store(env, 1, view(viewEnv.currentTabs));
    env = env_store(env, 3, viewMID(midVidMappings.mappings));
    return env;
}

