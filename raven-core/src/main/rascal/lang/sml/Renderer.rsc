module lang::sml::Renderer

import lang::raven::Raven;
import lang::sml::AST;
import lang::sml::Command;
import Map;
import Set;

//note: this might acutally be correct.
UUID nextID(Env env) {
  set[UUID] keys = domain(env);
  return max(keys)+1;
}

public Raven render(Env env) = 
  rvnTab("State Machine Language",
    [
      rvnButton("Create Machine", "MachCreate(<nextID(env)>)")
    ]
  );

public Raven render(Env env, AST m: machine(UUID id, str name, list[AST] es)) =
  rvnTab("State Machine Language",
    [
      rvnVertical
      (
        [
          rvnHorizontal
          (
            [
              rvnButton("-", "MachDelete(<id>)"),
              rvnLabel("machine"),
              rvnTextField(name, "MachSetName(<id>, %text)")
            ]
          )
        ] +
        [ render(env, s) | AST s <- es] +
        [ 
          rvnHorizontal
          (
            [
              rvnHorizontalSpace(40),
              rvnButton("+", "StateCreate(<nextID(env)>,<id>)")
            ]
          )
        ]        
      )
    ]
  );

public Raven render(Env env, AST s: state(UUID id, UUID mid, str name, list[AST] ts)) =
  rvnVertical
  (
    [
      rvnHorizontal
      (
        [
          rvnHorizontalSpace(40),            
          rvnButton("-", "StateDelete(<id>,<mid>)"),
          rvnLabel("state"),
          rvnTextField(name, "StateSetName(<id>, %text")
        ]
      )
    ] + 
    [ render(env, t) | AST t <- ts] +
    [ 
      rvnHorizontal
      (
        [
          rvnHorizontalSpace(40),
          rvnButton("+", "TransCreate(<nextID(env)>,<id>)")
        ]
      )
    ]
  );

public Raven render(Env env, AST t: trans(UUID id, UUID src, str trigger, UUID tgt)) =
  rvnHorizontal
  (
    [
      rvnButton("-", "TransDelete(<id>)"),
      rvnTextField(trigger, "TransSetTrigger(<id>, %text)"),
      rvnLabel(" --\> "),
      rvnOptionButton([name | state(_, _, name, _) <- env[1]]) 
      //FIXME: should be from the current machine these states are part of
    ]
  );