module lang::sml::AST

alias UUID = int;
alias ID = str;

data AST
  = empty()
  | machine(UUID id, ID name, list[AST] es)
  | state(UUID id, UUID mid, ID name, list[AST] ts)
  | trans(UUID id, UUID src, ID trigger, UUID tgt)
  ;


