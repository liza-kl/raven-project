module lang::sml::model::TreeRenderer

import lang::raven::RavenNode;
import lang::raven::Environment;
import lang::sml::model::Model;
import lang::sml::model::REPL;
import lang::sml::model::Command;
import Map;
import Set;
import util::Math;
import util::UUID;
import List;
import lang::Main;
import lang::sml::model::Styles;


// Render General Tab Content (Root) ? of Machine
// In Tree 
public RavenNode render(Env env, Model m: mach(UUID mid, str name, list[UUID] states, list[UUID] instances), "tree") =
  ravenHBox(
   // toString(nextID(env)), "State Machine Language <mid>: <name>",
    [
      ravenVBox
      (
        [ 
              ravenLabel("Available States", settings=h2FontSize)
            ]
          
         +
        [ render(env, getState(env, sid), "tree") | UUID sid <- states] 
      ,settings=vboxContainerStyles)
    ],settings=hboxContainerStyles
  );




public RavenNode render(Env env, Model s: state(UUID sid, UUID mid, str name, list[UUID] ti, list[UUID] to, int x, int y), "tree") =
  ravenVBox(
    [
      ravenHBox
      (
        [

          ravenLabel("Edit State Name", settings=bodyFontSize + hboxContainerHorizontalExpand),
          ravenTextEdit(name, "StateSetName(<sid>, %text)", settings=textEditSettings + hboxContainerHorizontalExpand),
          ravenButton("Delete State", "StateDelete(<sid>)", settings=buttonDanger + hboxContainerHorizontalExpand)
        ]
      , settings=hboxContainerStyles)
    ] + 
    [ render(env, getTrans(env, tid), "tree") | UUID tid <- to] +
    [ 
      ravenHBox
      (
        [
          ravenButton("Create New Transition for State: <name>", "TransCreateSource(<nextID(env)>,<sid>)",settings=buttonCreate + hboxContainerHorizontalExpand)
        ]
          
      ,settings=hboxContainerHorizontalExpand)
    ]
  );
public RavenNode render(Env env, Model t: trans(UUID id, UUID src, str trigger, UUID tgt), "tree") {
  UUID mid2 = lang::Main::env_retrieveMIDfromSID(src);
  return ravenHBox
  (
    [
      
      ravenTextEdit(trigger, "TransSetTrigger(<id>, %text)", settings=textEditSettings + hboxContainerHorizontalExpand),
      ravenLabel(" --\> " settings=bodyFontSize + hboxContainerHorizontalExpand),
      // TODO an adapter View Function?
      ravenOptionButton([name | elem <- env, state(_,mid2,name,_,_,_,_) := env[elem]],   "InterTransSetTarget(<id>,%state)",
      // Getting only the states available for that specific machine.
      settings=[setting("Primitive", [<"selected", "Int%<List::indexOf([sid | elem <- env, state(sid,mid2,name,_,_,_,_) := env[elem]],tgt)>">, <"allow_reselect", "Boolean%true">])]),
      ravenButton("Delete Transition", "TransDelete(<id>)", settings=buttonDanger  + hboxContainerHorizontalExpand)
      //FIXME: should be from the current machine these states are part of
    ]
  ,settings=hboxContainerHorizontalExpand); }

