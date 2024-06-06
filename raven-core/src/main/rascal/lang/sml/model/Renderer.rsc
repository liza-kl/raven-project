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
      ravenLabel("Available Machines", [setting("Color", [<"font_color", "LAVENDER">])])
      ] + [ ravenLabel(machine) | machine <- convertSetToList(domain(env))])
     // ravenOptionButton(convertSetToList(domain(env)), "InputCreate(%machID=selected)"),
    //  ravenOptionButton(["tree"], "InputCreate(%view=selected)"),
    ])]
    +
    [
      render(env, toString(tab[0]), tab[1]) | tab <- toList(env_retrieve(env, #ViewEnv, 1).currentTabs)
    ] 
    )
  ], true);

public RavenNode render(Env env,str tabID, Tab t: tab(tuple[str name, list[RavenNode] content] content)) =
  ravenTab(
    tabID,
    t.content.name,
    t.content.content
  );
  
  // TODO render this correctly somehow.
public RavenNode render(Env env, Model m: mach(UUID mid, str name, list[UUID] states, list[UUID] instances), "tree") =
  ravenHBox(
   // toString(nextID(env)), "State Machine Language <mid>: <name>",
    [
      ravenVBox
      (
        [
          ravenHBox
          (
            [
              ravenLabel("Machine Editor for <mid>"),
              ravenButton("Delete Machine", "MachDelete(<mid>)"),
              ravenLabel("Machine Name"),
              ravenTextEdit(name, "MachSetName(<mid>, %text)")
            ]
          )
        ] +
        [ render(env, getState(env, sid)) | UUID sid <- states] +
        [ 
          ravenHBox
          (
            [
              //  rvnHorizontalSpace(40), TODO leaving Horizontal space out for now
              ravenButton("Create State", "StateCreate(<nextID(env)>, <mid>)")
            ]
          )
        ]        
      )
    ]
  );

public RavenNode render(Env env, Model s: state(UUID sid, UUID mid, str name, list[UUID] ti, list[UUID] to, int x, int y)) =
  ravenVBox
  (
    [
      ravenHBox
      (
        [
          ravenLabel("Available States"),
         // TODO rvnHorizontalSpace(40), leaving Horizontal space out for now   
          ravenButton("Delete State", "StateDelete(<sid>,<mid>)"),
          ravenTextEdit(name, "StateSetName(<sid>, %text")
        ]
      )
    ] + 
    [ render(env, getTrans(env, tid)) | UUID tid <- to] +
    [ 
      ravenHBox
      (
        [
        // TODO rvnHorizontalSpace(40),  leaving Horizontal space out for now
          ravenButton("+", "TransCreateSource(<nextID(env)>,<sid>)")
        ]
      )
    ]
  );

public RavenNode render(Env env, Model t: trans(UUID id, UUID src, str trigger, UUID tgt)) =
  ravenHBox
  (
    [
      ravenButton("-", "TransDelete(<id>)"),
      ravenTextEdit(trigger, "TransSetTrigger(<id>, %text)"),
      ravenLabel(" --\> "),
      ravenOptionButton([name | state(_, _, name, _,_,_,_) <- env[1]])
      //FIXME: should be from the current machine these states are part of
    ]
  );

default RavenNode render(Env env) { throw "Cant find suitable render"; } 
