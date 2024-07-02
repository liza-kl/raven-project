module lang::sml::model::TreeRenderer

import lang::raven::RavenNode;
import lang::sml::Environment;
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
  ravenMarginContainer([
  ravenPanelContainer([
  ravenHBox( 
    [

    
      ravenVBox
      (
        // [
        //       ravenLabel("Tree Representation", settings=tableEditorHeadings)
        //       ravenLabel("Available States", settings=h2FontSize)
        //     ]
          
        //  +
        [
                 ravenVBox([
 ravenPanelContainer([
  ravenHBox([
                ravenLabel("Machine", settings=bodyFontSize),
                ravenTextEdit(name, "MachSetName(<mid>, %text)", settings=textEditSettings),
                ravenButton("X", "MachDelete(<mid>)", settings=buttonDanger)])] settings=panelTreeMachName)
                
                ], settings=hboxContainerStyles)
        ] +
        [ render(env, getState(env, sid), "tree") | UUID sid <- states] + 
        [
          ravenMarginContainer([
          ravenButton("+", "StateCreate(<nextID(env)>, <mid>)", settings=buttonCreate)], settings=marginContainerTreeEditor)] 
      ,settings=vBoxContainerCenter)
    ],settings=hboxContainerStyles
  )])], settings=marginContainerEven);




public RavenNode render(Env env, Model s: state(UUID sid, UUID mid, str name, list[UUID] ti, list[UUID] to, int x, int y), "tree") =
  ravenMarginContainer([
  ravenVBox(
    [
      ravenMarginContainer([
      ravenPanelContainer([
      ravenHBox
      (
        [

          ravenLabel("State", settings=bodyFontSize + hboxContainerHorizontalExpand),
          ravenTextEdit(name, "StateSetName(<sid>, %text)", settings=textEditSettings + hboxContainerHorizontalExpand),
          ravenButton("X", "StateDelete(<sid>)", settings=buttonDanger + hboxContainerHorizontalExpand)
        ]
      , settings=hboxContainerStyles)], settings=panelTreeEditorState)], settings=marginContainerTreeEditor)
    ] + 
    [ render(env, getTrans(env, tid), "tree") | UUID tid <- to] +
    [ 
        ravenMarginContainer([
      ravenHBox
      (
        [
          ravenButton("+", "TransCreateSource(<nextID(env)>,<sid>)",settings=buttonCreate + hboxContainerHorizontalExpand)
        ]
          
      ,settings=hboxContainerHorizontalExpand)], settings=marginContainerTreeEditor2)
    ]
  )]);


public RavenNode render(Env env, Model t: trans(UUID id, UUID src, str trigger, UUID tgt), "tree") {
  UUID mid2 = lang::Main::env_retrieveMIDfromSID(src);
  return 
  ravenMarginContainer([
  ravenPanelContainer([
  ravenHBox
  (
    [
      ravenLabel("Transition", settings=bodyFontSize + hboxContainerHorizontalExpand2),
      ravenTextEdit(trigger, "TransSetTrigger(<id>, %text)", settings=textEditSettings + hboxContainerHorizontalExpand2),
      ravenLabel(" =\> " settings=bodyFontSize + hboxContainerHorizontalExpand2),
      // TODO an adapter View Function?
      ravenOptionButton([name | elem <- env, state(_,mid2,name,_,_,_,_) := env[elem]],   "InterTransSetTarget(<id>,%state)",
      // Getting only the states available for that specific machine.
      settings= hboxContainerHorizontalExpand2 + [setting("Primitive", [<"selected", "Int%<List::indexOf([sid | elem <- env, state(sid,mid2,name,_,_,_,_) := env[elem]],tgt)>">, <"allow_reselect", "Boolean%true">])]),
      ravenButton("X", "TransDelete(<id>)", settings=buttonDanger  + hboxContainerHorizontalExpand2)
      //FIXME: should be from the current machine these states are part of
    ]
  ,settings=hboxContainerHorizontalExpand)], settings=panelTreeEditorEditState)], settings=marginContainerTreeEditor2); }

