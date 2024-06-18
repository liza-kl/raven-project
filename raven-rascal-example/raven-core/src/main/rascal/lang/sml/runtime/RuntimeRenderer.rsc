module lang::sml::runtime::RuntimeRenderer

import lang::raven::RavenNode;
import lang::sml::Environment;
import lang::sml::model::Model;
import lang::sml::runtime::Model;
import lang::sml::model::REPL;
import lang::sml::model::Command;
import Map;
import Set;
import lang::Main;
import util::Math;
import List;
import util::UUID;
import List;
import ValueIO;
import lang::sml::model::Styles;

import String;
import IO;


// To create the possible trigger events, apply to machine or curr state I guess.
list[str] getAllTrigger(Env env, UUID sid, UUID miid) {
    list[str] result = [trigger | t <- env, trans(_,sid,trigger,_) := env[t]];
    return result;
}

public int getDefiningState(Env env, UUID siid) {
    return [sid | t <- env,  stateInst(siid,sid,_) := env[t]][0];  
}
// The Renderer for a first runtime view ? 
public RavenNode render(Env env, machInst(UUID miid, UUID mid, UUID cur,  map[UUID sid, UUID siid] sis), "runtime-1") {
    

    return ravenVBox([
        ravenMarginContainer([
        ravenLabel("Possible Actions", settings=h2FontSize + hboxContainerHorizontalExpand)], settings=marginContainer5) 
    ] + [
        ravenButton(elem, "MachInstTrigger(<miid>,\\\"<elem>\\\")",settings=hboxContainerHorizontalExpand + buttonSubmit) | elem <-getAllTrigger(env,getDefiningState(env, cur), miid ) 
    ]+ [
        // The custom table, I guess
        ravenMarginContainer([ravenLabel("Current Program State", settings=h2FontSize + hboxContainerHorizontalExpand)], 
        settings=marginContainer5),
        ravenHBox([
            
            ravenPanelContainer([ravenHBox([ravenLabel("Current",settings=runtimeTabelLabel)])],settings=tableHeadingStyle),
            ravenPanelContainer([ravenHBox([ravenLabel("State",settings=runtimeTabelLabel)])],settings=tableHeadingStyle),
            ravenPanelContainer([ravenHBox([ravenLabel("Count",settings=runtimeTabelLabel)])],settings=tableHeadingStyle),
            ravenPanelContainer([ravenHBox([ravenLabel("Events", settings=runtimeTabelLabel)])],settings=tableHeadingStyle)
        ], settings=hboxContainerHorizontalExpand)
    ]+ 
    [render(env, env[t], cur, miid) | t <- env, stateInst(siid,sid,count) := env[t]],
    settings=hboxContainerHorizontalExpand);

}

public RavenNode render(Env env, stateInst(UUID siid, UUID sid, int count), UUID cur, UUID miid) {
    return ravenHBox([
            ravenPanelContainer([ravenHBox([ravenLabel("<if(cur == siid){>*<}>",settings=lang::sml::model::Styles::runtimeTabelLabel)])],settings=tableBodyStyle),
            ravenPanelContainer([ravenHBox([ravenLabel("<env[sid].name>",settings=lang::sml::model::Styles::runtimeTabelLabel)])],settings=tableBodyStyle),
            ravenPanelContainer([ravenHBox([ravenLabel("<count>",settings=lang::sml::model::Styles::runtimeTabelLabel)])],settings=tableBodyStyle),
            ravenPanelContainer([ravenHBox([ravenLabel("<replaceAll(itoString([elem | elem <- getAllTrigger(env, sid,miid)]),"\"", "")>",
                                settings=runtimeTabelLabel)
                                ])],
                                settings=tableBodyStyle)
        ],  settings=hboxContainerHorizontalExpand);
}