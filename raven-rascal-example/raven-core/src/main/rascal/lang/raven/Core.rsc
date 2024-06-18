module lang::raven::Core
import IO;
import lang::sml::model::Command;
import lang::sml::control::ViewCommand;
import lang::sml::control::Callbacks;
import lang::sml::control::ViewCallbacks;
import lang::sml::control::InputCallbacks;
import lang::sml::runtime::RuntimeCallbacks;
import lang::sml::runtime::Command;
import ValueIO;
import String;

/* TODO add different languages and prepend with languages VIEW_addTab, PROGRAM_updateEnv */ 
// TODO add parameter for language controller 
void dispatch(str callback) {
      //  print("Dispatching callback");
    if(startsWith(callback, "Input")) {
      //  println("Calling Input-Callback");
        lang::sml::control::InputCallbacks::inputControl(ValueIO::readTextValueString(#Command, callback));
    } else if(startsWith(callback, "View")) {
      //  println("Calling Viewcallback");
        lang::sml::control::ViewCallbacks::viewControl(ValueIO::readTextValueString(#Command, callback));
    } else if(startsWith(callback, "MachInst")) {
       // println("Calling MachInst-Callback");
        lang::sml::runtime::RuntimeCallbacks::runtimeControl(ValueIO::readTextValueString(#Command, callback));
    } else {
       // println("Calling Residual-Callback");
        lang::sml::control::Callbacks::viewControl(ValueIO::readTextValueString(#Command, callback));
    }
}

