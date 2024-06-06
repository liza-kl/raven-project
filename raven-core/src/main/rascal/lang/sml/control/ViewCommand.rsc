module lang::sml::control::ViewCommand

import lang::raven::Environment;

public data Command
  = ViewTabCreate(UUID vid)
  | ViewTabDelete(UUID vid)
  | ViewTabSetType(UUID vid, str t = "tree") // Setting the View Type 
  | ViewTabSetMachine(UUID vid, UUID mid)
  ;

  