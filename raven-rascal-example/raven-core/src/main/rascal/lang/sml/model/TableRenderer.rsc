module lang::sml::model::TableRenderer

import lang::raven::RavenNode;
import lang::sml::Environment;
import lang::sml::model::Model;
import lang::sml::model::REPL;
import lang::sml::model::Command;
import Map;
import IO;
import Set;
import lang::Main;
import util::Math;
import util::UUID;
import List;
import lang::sml::model::Styles;

// In Table View
public RavenNode render(Env env, Model m: mach(UUID mid, str name, list[UUID] states, list[UUID] instances), "table") =
  ravenVBox([
    ravenLabel("Table Representation", settings=tableEditorHeadings),
    ravenLabel("Modify States", settings=tableEditorHeadings),
    ravenVBox([ render(env, getState(env, sid), "table-heading") | UUID sid <- states] ),
    ravenButton("Create New State", "StateCreate(<nextID(env)>,<mid>)", settings=buttonCreate), // Maybe good case to show the input functionality?
    ravenLabel("Transition Table", settings=h2FontSize),
    ravenVBox([
    ravenHBox([
            ravenPanelContainer([ravenLabel("In State",settings=bodyFontSize + hboxContainerHorizontalExpand)], settings=panelTableEditor + bodyFontSize + hboxContainerHorizontalExpand ),
            ravenPanelContainer([ravenLabel("Action", settings=bodyFontSize + hboxContainerHorizontalExpand)],settings=panelTableEditor + bodyFontSize + hboxContainerHorizontalExpand  ),
            ravenPanelContainer([ravenLabel("Out State", settings=bodyFontSize +hboxContainerHorizontalExpand)],settings=panelTableEditor + bodyFontSize + hboxContainerHorizontalExpand  ),
            ravenPanelContainer([ravenLabel("",settings=bodyFontSize + hboxContainerHorizontalExpand)],settings=panelTableEditor + bodyFontSize + hboxContainerHorizontalExpand )

        ], settings=hboxContainerHorizontalExpand)
        
  ], settings=hboxContainerHorizontalExpand   ),
  // FIXME currently hardcoded
  ravenVBox([render(env, getState(env, sid), "table-body") |  sid <- states] + ravenButton("Create new Transition","TransCreateSource(<nextID(env)>,<states[0]>)",settings=buttonCreate)) 

    ],settings=vboxContainerStyles);



public RavenNode render(Env env, Model s: state(UUID sid, UUID mid, str name, list[UUID] ti, list[UUID] to, int x, int y), "table-heading") =
      ravenHBox
      (
        [
          ravenPanelContainer([ravenLabel("Edit State Name", settings=bodyFontSize + hboxContainerHorizontalExpand)],settings=panelTableEditor + bodyFontSize + hboxContainerHorizontalExpand),
          ravenPanelContainer([ravenTextEdit(name, "StateSetName(<sid>, %text)",  settings=textEditSettings + hboxContainerHorizontalExpand)], settings =  bodyFontSize + hboxContainerHorizontalExpand),
          ravenPanelContainer([ravenButton("Delete State", "StateDelete(<sid>)", settings=buttonDanger + hboxContainerHorizontalExpand)],settings=panelTableEditor + bodyFontSize + hboxContainerHorizontalExpand)
        ],settings=hboxContainerHorizontalExpand
      );

public RavenNode render(Env env, Model s: state(UUID sid, UUID mid, str name, list[UUID] ti, list[UUID] to, int x, int y), "table-body") {    
    
    for(transitionID <- to + ti) {
     return render(env, getTrans(env, transitionID), "table");
    }
    return empty();
   } 



public RavenNode render(Env env, Model t: trans(UUID id, UUID src, str trigger, UUID tgt), "table") {
  UUID mid2 = lang::Main::env_retrieveMIDfromSID(src);

  return ravenHBox
  (
    [
      ravenPanelContainer([ravenOptionButton([name | elem <- env, state(_,mid2,name,_,_,_,_) := env[elem]],   "InterTransSetTarget(<id>,%state)",
      // Getting only the states available for that specific machine.
      settings= optionButtonSettings + [setting("Primitive", [<"selected", "Int%<List::indexOf([sid | elem <- env, state(sid,mid2,name,_,_,_,_) := env[elem]],src)>">, <"allow_reselect", "Boolean%true">])])]),

      ravenPanelContainer([ravenTextEdit(trigger, "TransSetTrigger(<id>, %text)", settings=textEditSettings)]),  
      ravenPanelContainer([ravenOptionButton([name | elem <- env, state(_,mid2,name,_,_,_,_) := env[elem]],   "InterTransSetTarget(<id>,%state)",
      // Getting only the states available for that specific machine.
      settings=optionButtonSettings + [setting("Primitive", [<"selected", "Int%<List::indexOf([sid | elem <- env, state(sid,mid2,name,_,_,_,_) := env[elem]],tgt)>">, <"allow_reselect", "Boolean%true">])])]),
      ravenPanelContainer([ravenButton("Delete Transition", "TransDelete(<id>)", settings=buttonDanger)])

      //FIXME: should be from the current machine these states are part of
    ],settings=hboxContainerStyles
  ); }
