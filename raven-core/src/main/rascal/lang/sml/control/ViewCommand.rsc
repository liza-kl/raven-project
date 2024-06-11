module lang::sml::control::ViewCommand

import lang::raven::Environment;
import lang::raven::RavenNode;

public data Command
  = ViewTabCreate(UUID vid)
 // | ViewTabCreate(UUID vid, str name, int mid, str viewType, RavenNode content)
  | ViewTabDelete(UUID vid)
  | ViewTabSetType(UUID vid, str viewType) // Setting the View Type 
  | ViewTabSetMachine(UUID vid, UUID mid)
  | ViewTabSetCurrentTab(UUID tabID)
  ;

  