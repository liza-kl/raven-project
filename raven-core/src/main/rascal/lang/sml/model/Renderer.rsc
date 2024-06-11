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
             
              ravenLabel("Available States")
            ]
          )
        ] +
        [ render(env, getState(env, sid), "tree") | UUID sid <- states] 
        // + [ 
        //   ravenHBox
        //   (
        //     [
        //       ravenButton("Create State", "StateCreate(<nextID(env)>, <mid>)")
        //     ]
        //   )
        // ]        
      )
   //  ravenVBox([]) TODO will be fixed later with proper spacing.
    ]
  );

public RavenNode render(Env env, Model s: state(UUID sid, UUID mid, str name, list[UUID] ti, list[UUID] to, int x, int y), "tree") =
  ravenVBox
  (
    [
      ravenHBox
      (
        [
         // TODO rvnHorizontalSpace(40), leaving Horizontal space out for now   
         // TODO do we need the mid for the state??
          ravenLabel("Edit State Name"),
          ravenTextEdit(name, "StateSetName(<sid>, %text)"),
          ravenButton("Delete State", "StateDelete(<sid>)")
        ]
      )
    ] + 
    [ render(env, getTrans(env, tid), "tree") | UUID tid <- to] +
    [ 
      ravenHBox
      (
        [
        // TODO rvnHorizontalSpace(40),  leaving Horizontal space out for now
          ravenButton("Create Trans Source", "TransCreateSource(<nextID(env)>,<sid>)")
        ]
          
      )
    ]
  );
// TODO need to differentiate for different view types.
public RavenNode render(Env env, Model t: trans(UUID id, UUID src, str trigger, UUID tgt), "tree") {
  UUID mid2 = lang::Main::env_retrieveMIDfromSID(src);
  return ravenHBox
  (
    [
      ravenButton("Delete Transition", "TransDelete(<id>)"),
      ravenTextEdit(trigger, "TransSetTrigger(<id>, %text)"),
      ravenLabel(" --\> "),
      // TODO an adapter View Function?
      ravenOptionButton([name | elem <- env, state(_,mid2,name,_,_,_,_) := env[elem]],   "InterTransSetTarget(<id>,%state)",
      // Getting only the states available for that specific machine.
      [setting("Primitive", [<"selected", "Int%<List::indexOf([sid | elem <- env, state(sid,mid2,name,_,_,_,_) := env[elem]],tgt)>">, <"allow_reselect", "Boolean%true">])])
      //FIXME: should be from the current machine these states are part of
    ]
  ); }


default RavenNode render(Env env) { throw "Cant find suitable render"; } 
