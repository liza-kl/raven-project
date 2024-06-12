module lang::sml::control::ViewCommand

import lang::raven::Environment;
import lang::raven::RavenNode;
import lang::Main; 

public data Command
  = ViewTabCreate(UUID vid)
  | ViewTabDelete(UUID vid)
  | ViewTabSetType(UUID vid, str viewType) // Setting the View Type 
  | ViewTabSetMachine(UUID vid, UUID mid)
  | ViewTabSetCurrentTab(UUID tabID)
  ;

  