module Helpers::Setup
import ApplicationConf;
/** 
* A module with helper functions for setting up for a new language
**/
public void startGodotEngine() {
PID current = createProcess(GODOT_CMD, workingDir=RAVEN_WORK_DIR);
}
