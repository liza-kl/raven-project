module lang::raven::Core
import IO;
import lang::sml::model::Command;
import lang::sml::control::ViewCommand;
import lang::sml::control::Callbacks;
import lang::sml::control::ViewCallbacks;
import lang::sml::control::InputCallbacks;
import ValueIO;
import String;
import IO;

/* TODO add different languages and prepend with languages VIEW_addTab, PROGRAM_updateEnv */ 
// TODO add parameter for language controller 
void dispatch(str callback) {
    print("dispatching callback");

    if(startsWith(callback, "Input")) {
        println("calling viewcallback");

        lang::sml::control::InputCallbacks::inputControl(ValueIO::readTextValueString(#Command, callback));

    } else if(startsWith(callback, "View")) {
        println("calling viewcallback");
        lang::sml::control::ViewCallbacks::viewControl(ValueIO::readTextValueString(#Command, callback));
    } else {
                println("calling residual");
        lang::sml::control::Callbacks::viewControl(ValueIO::readTextValueString(#Command, callback));

}
}

