package cwi.masterthesis.raven.interpreter;

import cwi.masterthesis.raven.interpreter.nodes.RavenButton;
import cwi.masterthesis.raven.interpreter.nodes.RavenLabel;
import cwi.masterthesis.raven.interpreter.nodes.RavenNode2D;
import godot.Button;
import godot.Label;
import godot.Node;
import godot.Node2D;
import godot.core.Vector2;

public class Interpreter implements Visitor {

    public void addChildren(Node child, Node parentNode) {
        parentNode.addChild(child);
    }

    @Override
    public void visitButton(RavenButton ravenButton) {
        System.out.println("Creating Button");
        var button = new Button();
        button.setText(ravenButton.getLabel());
        button.setPosition(new Vector2(ravenButton.getXCoordinate(), ravenButton.getYCoordinate()));

        button.getChildren().forEach(child -> addChildren(button, child));
        ravenButton.getParentNode().addChild(button);
    }

    @Override
    public void visitLabel(RavenLabel ravenLabel) {
        System.out.println("Creating Label");

        var label = new Label();
        label.setText(ravenLabel.getLabel());
        label.setPosition(new Vector2(ravenLabel.getXCoordinate(), ravenLabel.getYCoordinate()));
        ravenLabel.getParentNode().addChild(label);
    }

    @Override
    public void visitNode2D(RavenNode2D ravenNode2D) {
        System.out.println("Creating Node2D");
        var node2D = new Node2D();
        node2D.getParent().addChild(node2D);
    }



}
