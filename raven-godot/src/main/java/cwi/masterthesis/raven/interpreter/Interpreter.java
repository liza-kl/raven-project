package cwi.masterthesis.raven.interpreter;

import cwi.masterthesis.raven.interpreter.nodes.RavenButton;
import cwi.masterthesis.raven.interpreter.nodes.RavenLabel;
import cwi.masterthesis.raven.interpreter.nodes.RavenNode2D;
import godot.*;
import godot.core.NodePath;
import godot.core.StringNameUtils;
import godot.core.Vector2;
import godot.global.GD;

public class Interpreter extends Node implements Visitor {

    public void addChildren(Node child, Node parentNode) {
        parentNode.addChild(child);
    }

    @Override
    public void visitButton(RavenButton ravenButton) {
        System.out.println("Creating Button");
        PackedScene DefaultButtonLook = GD.load("res://scenes/DefaultButton.tscn");
        assert DefaultButtonLook != null;
        var buttonNode = new RavenButton();

        assert buttonNode != null;
        Button button = (Button) buttonNode.getNode(new NodePath("."));

        assert button != null;
        //button.setScript(GD.load("res://gdj/cwi/masterthesis/raven/buttons/UpdateSceneButton.gdj"));
        button.setText(ravenButton.getLabel());
        button.setPosition(new Vector2(ravenButton.getXCoordinate(), ravenButton.getYCoordinate()));
        System.out.println(button.getScript());
        button.getChildren().forEach(child -> addChildren(button, child));
        button.set(StringNameUtils.asStringName("btn_callback"), ravenButton.getCallback());
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
