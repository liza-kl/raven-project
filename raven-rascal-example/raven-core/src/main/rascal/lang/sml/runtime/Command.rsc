module lang::sml::runtime::Command

import lang::sml::Environment;

data Command
  = MachInstCreate(UUID miid, UUID mid)      //creates an instance of a machine (user action)
  | MachInstDelete(UUID miid, UUID mid)      //deletes a machine instance (user action)
  | MachInstTrigger(UUID miid, str trigger)  //triggers an event that can cause a transition (user action)
  | MachInstInitialize(UUID miid)            //initializes a machine instance
  | MachInstSetCurState(UUID miid, UUID sid) //sets the current state
  | MachInstMissingCurState(UUID miid)       //exception during a transition
  | MachInstQuiescence(UUID miid)            //no transition happened
  | MachInstAddStateInst(UUID miid, UUID sid, UUID siid)    //add a state instance
  | MachInstRemoveStateInst(UUID miid, UUID sid, UUID siid) //remove a state instance
  | StateInstCreate(UUID siid, UUID sid, UUID miid)     //create a state instance
  | StateInstSetCount(UUID siid, int count)  //sets the current visited count
  | StateInstDelete(UUID siid, UUID miid)    //deletes a state instance
  ;