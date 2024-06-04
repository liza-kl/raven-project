module lang::sml::Renderer
import lang::sml::control::AST;
import Interpreter::RavenNode;
import lang::sml::AST;
import lang::sml::Command;
import Map;
import Helpers::Utils;
import Set;


//note: this might acutally be correct.
UUID nextID(Env env) {
  set[UUID] keys = domain(env);
  return max(keys)+1;
}

public RavenNode render(Env env) = 
  ravenTab("State Machine Language",
    [
      ravenButton("Create New Machine", "MachCreate(<nextID(env)>)"),
      ravenOptionButton(convertSetToList(domain(env)))
    ]
  );

public RavenNode render(Env env, AST m: machine(UUID id, str name, list[AST] es), View view: tree()) =
  ravenTab("Machine Editor <m.id>",
    [
      ravenVBox
      (
        [
          ravenVBox
          (
            [
              ravenButton("Delete Machine", "MachDelete(<id>)"),
              ravenLabel("Machine Name: <name>"),
              ravenTextEdit(name, "MachSetName(<id>, %text)")
            ]
          )
        ] +
        [ render(env, s) | AST s <- es] +
        [ 
          ravenHBox
          (
            [
              //  rvnHorizontalSpace(40), TODO leaving Horizontal space out for now
              ravenButton("Add State +", "StateCreate(<nextID(env)>,<id>)")
            ]
          )
        ]        
      )
    ]
  );

public RavenNode render(Env env, AST s: state(UUID id, UUID mid, str name, list[AST] ts)) =
  ravenVBox
  (
    [
      ravenHBox
      (
        [
         // TODO rvnHorizontalSpace(40), leaving Horizontal space out for now   
          ravenButton("-", "StateDelete(<id>,<mid>)"),
          ravenLabel("state"),
          ravenTextEdit(name, "StateSetName(<id>, %text")
        ]
      )
    ] + 
    [ render(env, t) | AST t <- ts] +
    [ 
      ravenHBox
      (
        [
        // TODO rvnHorizontalSpace(40),  leaving Horizontal space out for now
          ravenButton("Trans Create +", "TransCreate(<nextID(env)>,<id>)")
        ]
      )
    ]
  );

public RavenNode render(Env env, AST t: trans(UUID id, UUID src, str trigger, UUID tgt)) =
  ravenHBox
  (
    [
      ravenButton("-", "TransDelete(<id>)"),
      ravenTextEdit(trigger, "TransSetTrigger(<id>, %text)"),
      ravenLabel(" --\> "),
      ravenOptionButton([name | state(_, _, name, _) <- env[1]])
      //FIXME: should be from the current machine these states are part of
    ]
  );