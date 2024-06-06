module lang::sml::control::REPL

import lang::sml::control::ViewCommand;
import lang::sml::control::InputCommand;
import lang::raven::Environment;
import lang::Main;

public Env eval(Env env, Command cmd: ViewTabCreate(UUID vid)) {

    return env;
}

public Env eval(Env env, Command cmd: ViewTabDelete(UUID vid)) {
    return env;
}

public Env eval(Env env, Command cmd: ViewTabSetType(UUID vid)) {
    return env;
}

public Env eval(Env env, Command cmd: ViewTabSetMachine(UUID vid, UUID mid)) {
    ViewEnv viewEnv = env_retrieve(env, #ViewEnv, 1);
    map[int, Tab] currentTabs = viewEnv.currentTabs; 
    Tab retrievedView = currentTabs[vid]; 
    retrievedView.mid = mid;
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
     return inputEnv.stagedValues;
}