package cwi.masterthesis.raven;

import cwi.masterthesis.raven.files.FileUtils;
import cwi.masterthesis.raven.interpreter.Interpreter;
import cwi.masterthesis.raven.interpreter.nodes.RavenButton;
import cwi.masterthesis.raven.interpreter.nodes.RavenLabel;
import godot.Node;
import godot.annotation.RegisterClass;
import godot.annotation.RegisterFunction;
import godot.core.NodePath;

@RegisterClass
public class Main extends Node {

    @RegisterFunction
    @Override
    public void _ready() {
        System.out.println("Started Application");
        var incButton = new RavenButton(getNode(new NodePath(".")), "+",10,2, "inc()");
        var decButton = new RavenButton(getNode(new NodePath(".")), "-",15,2,"dec()");

        var label = new RavenLabel(getNode(new NodePath(".")), "My Counter Application", 10,5);
        var interpreter = new Interpreter();
        interpreter.visitButton(incButton);
        interpreter.visitButton(decButton);

        interpreter.visitLabel(label);
        FileUtils.createAProtocolFile();
    }



}
