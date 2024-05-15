module lang::sml::Syntax

//note: for reference only, currently not used
//to program SML, use the REPL instead

syntax Element 
  = machine: "machine" ID name Element* elements
  | state: "state" ID name Element+ elements
  | trans: ID trigger "-\>" ID tgt
  ;

lexical ID
  = id: [a-zA-Z]+[a-zA-Z0-9]*;