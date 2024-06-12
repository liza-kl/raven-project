module lang::sml::model::TreeRenderer

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


// Render General Tab Content (Root) ? of Machine
// In Tree 
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

