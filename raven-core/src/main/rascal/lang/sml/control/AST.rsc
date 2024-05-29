module lang::sml::control::AST

import lang::sml::AST;

public data View = tree() | graph() | table();
public alias BookKeeping = lrel[UUID,View];

