module lang::sml::control::InputCommand

public data Command
  = InputCreate(value val)
  | InputRetrieve()
  | InputClear();
