module lang::sml::model::TableRenderer

import lang::raven::RavenNode;
import lang::raven::Environment;
import lang::sml::model::Model;
import lang::sml::model::REPL;
import lang::sml::model::Command;
import lang::raven::helpers::Utils;
import Map;
import Set;
import lang::Main;
import util::Math;
import util::UUID;
import List;
import lang::Main;


// In Table View
public RavenNode render(Env env, Model m: mach(UUID mid, str name, list[UUID] states, list[UUID] instances), "table") =
  ravenHBox([ravenLabel("Table Representation 🌺")]);
