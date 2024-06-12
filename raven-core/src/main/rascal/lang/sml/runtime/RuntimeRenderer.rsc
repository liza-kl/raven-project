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


// To create the possible trigger events, apply to machine or curr state I guess.
list[str] getAllTrigger(Env env, UUID sid, UUID miid) {
    list[str] result = [trigger | t <- env, trans(_,sid,trigger,_) := env[t]];
    println("result");
    println(result);
    CurrentPossibleTriggers currentPossibleTriggersEnv = env_retrieve(env, #CurrentPossibleTriggers, 6);
    currentPossibleTriggersEnv.mappings[miid] = result;
    env = env_store(env, 6, currentPossibleTriggers(currentPossibleTriggersEnv.mappings));
    println("env after trigger");
    println(env);
    return result;
}

int getDefiningState(Env env, UUID siid) {
    return [sid | t <- env,  stateInst(siid,sid,_) := env[t]][0];  
}
// The Renderer for a first runtime view ? 
public RavenNode render(Env env, machInst(UUID miid, UUID mid, UUID cur,  map[UUID sid, UUID siid] sis), "runtime-1") {
    map[int, list[str]] mappings = env_retrieve(env, #CurrentPossibleTriggers, 6).mappings;
    return ravenVBox([
        ravenLabel("Possible trigger, dependening on curr event") 
    ] + [
        // TODO how to parse that correctly ...
        // Maybe define again a mapping in the env for possible values and their id?
        ravenButton(elem, "MachInstIntermTrigger(<miid>,<indexOf(mappings[miid],elem)>)") |
                    elem <- mappings[miid] 
    ]+ [
        // The custom table, I guess
        ravenHBox([
            ravenLabel("|   "),
            ravenLabel("    State   "),
            ravenLabel("|   Count   "),
            ravenLabel("|   Events  ")
        ])
    ]+ 
    [render(env, env[t], cur, miid) | t <- env, stateInst(siid,sid,count) := env[t]]);
}

public RavenNode render(Env env, stateInst(UUID siid, UUID sid, int count), UUID cur, UUID miid) {
    return ravenHBox([
            ravenLabel("<if(cur == siid){>*     |<}>"),
            ravenLabel("    <env[sid].name>"),
            ravenLabel("|   <count>"),
            ravenLabel("|   <replaceAll(itoString([elem | elem <- getAllTrigger(env, sid,miid)]), "\"", "")>")
        ]);
}