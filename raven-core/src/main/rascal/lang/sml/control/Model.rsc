module lang::sml::control::Model

import lang::raven::Env;
import lang::sml::model::Model;

public data View = tree() | graph() | table();
public alias BookKeeping = lrel[UUID,View];

