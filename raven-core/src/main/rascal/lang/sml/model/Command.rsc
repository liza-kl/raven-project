module lang::sml::model::Command

import lang::raven::Environment;

//Sequential Command Language
public data Command
  = MachCreate(UUID mid)                      //creates a machine (coding action)
  | MachDelete(UUID mid)                      //deletes a machine (coding action)
  | MachSetName(UUID mid, str name)           //renames a machine (coding action)
  | MachAddState(UUID mid, UUID sid)          //adds a state
  | MachRemoveState(UUID mid, UUID sid)       //removes a state
  | MachAddMachInst(UUID mid, UUID miid)      //adds a state instance
  | MachRemoveMachInst(UUID mid, UUID miid)   //removes a state instance
  | StateCreate(UUID sid, UUID mid)           //creates a state in a machine (coding action)
  | StateSetName(UUID sid, str name)          //renames a state (coding action)
  | StateDelete(UUID sid)                     //deletes a state from a machine (coding action)
  | StateAddIn(UUID sid, UUID tid)            //adds an input transition to a state
  | StateRemoveIn(UUID sid, UUID tid)         //removes an input transition from a state
  | StateAddOut(UUID sid, UUID tid)           //adds an output transition to a state
  | StateRemoveOut(UUID sid, UUID tid)        //removes an output transition from a state
  | TransCreate(UUID tid, UUID src, UUID tgt) //creates a transition (coding action in graph-based editor)
  | TransCreateSource(UUID tid, UUID src)     //creates a transition without a target (coding action in tree-based editor)
  | TransSetTrigger(UUID tid, str trigger)    //sets the trigger of a transition (coding action)
  | TransSetTarget(UUID tid, UUID tgt)        //sets the target of a transition (coding action in tree-based editor)
  | TransDelete(UUID tid)                     //deletes a transition (coding action)
  ;