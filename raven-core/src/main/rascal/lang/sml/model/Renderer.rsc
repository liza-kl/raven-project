module lang::sml::model::Renderer

import lang::raven::RavenNode;
import lang::raven::Env;


import lang::sml::control::Model;
import lang::sml::model::Model;
import lang::sml::model::REPL;
import lang::sml::model::Command;

import Map;
import Set;


//note: this might acutally be correct: NOTE = hacky
UUID nextID(Env env) {
  set[UUID] keys = domain(env);
  return max(keys)+1;
}

public RavenNode render(Env env) = 
  ravenTab("State Machine Language",
    [
      ravenButton("Create Machine", "MachCreate(<nextID(env)>)")
      //ravenOptionButton(convertSetToList(domain(env)))
    ]
  );

public RavenNode render(Env env, Model m: mach(UUID mid, str name, list[UUID] states, list[UUID] instances), View view: tree()) =
  ravenTab("State Machine Language <mid>: <name>",
    [
      ravenVBox
      (
        [
          ravenHBox
          (
            [
              ravenButton("-", "MachDelete(<mid>)"),
              ravenLabel("machine"),
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
              ravenButton("+", "StateCreate(<nextID(env)>, <mid>)")
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
         // TODO rvnHorizontalSpace(40), leaving Horizontal space out for now   
          ravenButton("-", "StateDelete(<sid>,<mid>)"),
          ravenLabel("state"),
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
      ravenLabel(" --\> ")
     //ravenOptionButton([name | state(_, _, name, _) <- env[1]]) 
      //FIXME: should be from the current machine these states are part of
    ]
  );