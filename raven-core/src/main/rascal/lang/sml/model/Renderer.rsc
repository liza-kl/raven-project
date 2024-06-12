module lang::sml::model::Renderer

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

extend lang::sml::model::TableRenderer;
extend lang::sml::model::TreeRenderer; 
extend lang::sml::runtime::RuntimeRenderer; 

data Tab = tab(tuple[str name, list[RavenNode] content] content);
//note: this might acutally be correct: NOTE = hacky
UUID nextID(Env env) {
  set[UUID] keys = domain(env);
  return max(keys)+1;
}

// UUID nextVid(lang::Main::ViewEnv view) {
//   set[UUID] keys = domain(view.currentTabs);
//   return max(keys)+1; 
// }

public RavenNode render(Env env) = 
 ravenNode2D("root", [ravenTabContainer([
  ravenTab(toString(nextID(env)),"State Machine Language",
    [
      ravenVBox([
      ravenLabel("State Machines Everywhere!", [setting("Color", [<"font_color", "LAVENDER">])]),
      ravenButton("Create New Machine", "MachCreate(<nextID(env)>)"),
      ravenButton("Open New Tab", "ViewTabCreate(<uuidi()>)")
      ]),
      ravenVBox([
      ravenLabel("Available Machines", [setting("Color", [<"font_color", "CRIMSON">])])
      ] //+ [ ravenLabel(machine) | machine <- convertSetToList(domain(env))] 
      + [ravenLabel(toString(mid)) | elem <- env, mach( mid, _, _, _) := env[elem]]
      )
    ])]
    +
    [
      render(env, toString(tab[0]), tab[1]) | tab <- toList(env_retrieve(env, #ViewEnv, 1).currentTabs)
    ],
    [setting("Primitive", [<"current_tab", "Int%<env[4].tabIndex>">])]
    )
  ], true);

public RavenNode render(Env env,str tabID, Tab t: tab(tuple[str name, list[RavenNode] content] content)) =
  ravenTab(
    tabID,
    t.content.name,
    t.content.content
  );
  


default RavenNode render(Env env) { throw "Cant find suitable render"; } 
