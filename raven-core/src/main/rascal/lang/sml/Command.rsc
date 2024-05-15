module lang::sml::Command

import lang::sml::AST;

alias Env = map[UUID, AST];

//Sequential Command Language
data Command
  = MachCreate(UUID mid)                      //creates a machine
  | MachDelete(UUID mid)                      //deletes a machine
  | MachSetName(UUID mid, str name)           //renames a machine
  | StateCreate(UUID sid, UUID mid)           //creates a state in a machine
  | StateSetName(UUID sid, str name)          //renames a state
  | StateDelete(UUID sid)                     //deletes a state from a machine
  | TransCreate(UUID tid, UUID src, UUID tgt) //creates a transition
  | TransCreate(UUID tid, UUID src)           //creates a transition
  | TransSetTrigger(UUID tid, str trigger)    //sets the trigger of a transition
  | TransSetTarget(UUID tid, UUID tgt)        //sets the target of a transition
  | TransDelete(UUID tid)                     //deletes a transition
  //run machine instance: (not yet implemented)
  | MachInstanceCreate(UUID miid, UUID mid)     //creates an instance of a machine
  | MachInstanceDelete(UUID miid)               //deletes a machine instance
  | MachInstanceTrigger(UUID miid, str trigger) //triggers an event that can cause a transition
  | StateInstanceCreate(UUID siid, UUID sid)    //create a state instance
  | StateInstanceIncrement(UUID siid)           //increments the state instance by opened
  | StateInstanceDelete(UUID siid)
  ;

