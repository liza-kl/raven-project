module lang::sml::control::ViewCommand

import lang::sml::Environment;
import lang::raven::RavenNode;
import lang::Main; 

public data Command
  = ViewTabCreate(UUID vid)
  | ViewTabMachineInsCreate(UUID vid)
  | ViewTabDelete(UUID vid)
  | ViewTabSetType(UUID vid, str viewType) // Setting the View Type 
  | ViewTabSetMachine(UUID vid, UUID mid)
  | ViewTabSetMachineInstance(UUID vid, UUID miid)
  | ViewTabSetCurrentTab(UUID tabID)
  ;

  