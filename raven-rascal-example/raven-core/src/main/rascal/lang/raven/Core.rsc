module lang::raven::Core



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
