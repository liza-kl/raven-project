module lang::raven::Core
import util::Benchmark;
import IO;



void dispatch(str callback) {
    int startTime =  getMilliTime();
    instance[0](callback);
    int endTime = getMilliTime();
    println("Execution of  @dispatch in Rascal ");
    println(endTime-startTime);
}

// Define a type alias for the dispatcher map
alias RavenApp = map[int, void(str)];

private RavenApp instance = ();

// Function to create a new RavenApp
void newRavenApp(void(str) dispatch) {
    instance[0] = dispatch;
}
