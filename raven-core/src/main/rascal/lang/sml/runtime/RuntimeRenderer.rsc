module lang::sml::runtime::RuntimeRenderer

import lang::raven::RavenNode;
import lang::raven::Environment;
import lang::sml::model::Model;
import lang::sml::runtime::Model;
import lang::sml::model::REPL;
import lang::sml::model::Command;
import lang::raven::helpers::Utils;
import Map;
import Set;
import lang::Main;
import util::Math;
import List;
import util::UUID;
import List;
import ValueIO;


import String;
import lang::Main;
import IO;

list[Setting] ravenPanelStyle =[setting("StyleBoxFlat",
                                        [setting(
                                            "panel",
                                            [<"bg_color", "HONEYDEW">]
                                        )])]; 

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
        ravenLabel("Possible trigger, dependening on curr event") 
    ] + [
        // TODO how to parse that correctly ...
        // Maybe define again a mapping in the env for possible values and their id?
        ravenButton(elem, "MachInstTrigger(<miid>,\\\"<elem>\\\")") | elem <-getAllTrigger(env,getDefiningState(env, cur), miid) 
    ]+ [
        // The custom table, I guess
        ravenHBox([
            
            ravenPanelContainer([ravenHBox([ravenLabel("Current State",[setting("FontSize", [<"font_size", 50>])])])]),
            ravenPanelContainer([ravenHBox([ravenLabel("State", [setting("FontSize", [<"font_size", 50>])])])]),
            ravenPanelContainer([ravenHBox([ravenLabel("Count",[setting("FontSize", [<"font_size", 50>])])])]),
            ravenPanelContainer([ravenHBox([ravenLabel("Events", [setting("FontSize", [<"font_size", 50>])])])])
        ])
    ]+ 
    [render(env, env[t], cur, miid) | t <- env, stateInst(siid,sid,count) := env[t]]);

}

public RavenNode render(Env env, stateInst(UUID siid, UUID sid, int count), UUID cur, UUID miid) {
    println("calling  render(Env env, stateInst(UUID siid, UUID sid, int count), UUID cur, UUID miid) ");


    return ravenHBox([
            ravenPanelContainer([ravenHBox([ravenLabel("<if(cur == siid){>*<}>",[setting("FontSize", [<"font_size", 50>])])])]),
            ravenPanelContainer([ravenHBox([ravenLabel("<env[sid].name>",[setting("FontSize", [<"font_size", 50>])])])],settings=ravenPanelStyle),
            ravenPanelContainer([ravenHBox([ravenLabel("<count>",[setting("FontSize", [<"font_size", 50>])])])],settings=ravenPanelStyle),
            ravenPanelContainer([ravenHBox([ravenLabel("<replaceAll(itoString([elem | elem <- getAllTrigger(env, sid,miid)]),"\"", "")>",
                                [setting("FontSize",
                                        [<"font_size", 50>])])
                                ])],
                                settings=ravenPanelStyle)
        ]);
}