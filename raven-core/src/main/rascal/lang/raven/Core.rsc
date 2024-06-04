module lang::raven::Core
import IO;
import lang::sml::model::Command;
import lang::sml::control::Callbacks;
import ValueIO;

/* TODO add different languages and prepend with languages VIEW_addTab, PROGRAM_updateEnv */ 
// TODO add parameter for language controller 
void dispatch(str callback) {
    print("dispatching callback");
        lang::sml::control::Callbacks::viewControl(ValueIO::readTextValueString(#Command, callback));
}

