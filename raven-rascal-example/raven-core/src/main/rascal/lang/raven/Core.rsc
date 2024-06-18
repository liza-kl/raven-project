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



void dispatch(str callback) {
    instance[0](callback);
}

// Define a type alias for the dispatcher map
alias RavenApp = map[int, void(str)];

private RavenApp instance = ();

// Function to create a new RavenApp
void newRavenApp(void(str) dispatch) {
    instance[0] = dispatch;
}
