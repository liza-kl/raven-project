package cwi.masterthesis.raven.interpreter;

import cwi.masterthesis.raven.interpreter.nodes.*;
import godot.*;
import godot.core.NodePath;
import godot.core.StringNameUtils;
import godot.core.Vector2;
import godot.global.GD;

import java.util.Objects;

public class Interpreter extends Node implements Visitor {

    public void addChildren(Node child, Node parentNode) {
        parentNode.addChild(child);
    }

    @Override
    public void visitButton(RavenButton ravenButton)  {
        System.out.println("Creating Button");
        PackedScene DefaultButtonLook = GD.load("res://scenes/DefaultButton.tscn");
        assert DefaultButtonLook != null;
        RavenButton buttonNode = new RavenButton();

        assert buttonNode != null;
        Button button = (Button) buttonNode.getNode(new NodePath("."));

        assert button != null;
        button.setText(ravenButton.getLabel());
        button.setName(StringNameUtils.asStringName(ravenButton.getNodeID()));

        button.setPosition(new Vector2(ravenButton.getXCoordinate(), ravenButton.getYCoordinate()));
        System.out.println(button.getScript());
        button.getChildren().forEach(child -> addChildren(button, child));
        button.setScript(GD.load("res://gdj/cwi/masterthesis/raven/scripts/ButtonSendMessage.gdj"));
        button.set(StringNameUtils.asStringName("btn_id"), ravenButton.getNodeID());
        button.set(StringNameUtils.asStringName("btn_callback"), ravenButton.getCallback());
        ravenButton.getParentNode().addChild(button);

    }

    @Override
    public void visitLabel(RavenLabel ravenLabel) {
        System.out.println("Creating Label");
        Label label = new Label();
        label.setName(StringNameUtils.asStringName(ravenLabel.getNodeID()));
        label.setText(ravenLabel.getLabel());
        label.setPosition(new Vector2(ravenLabel.getXCoordinate(), ravenLabel.getYCoordinate()));
        ravenLabel.getParentNode().addChild(label);
    }

    @Override
    public void visitNode2D(RavenNode2D ravenNode2D) {
        System.out.println("Creating Node2D");
        Node2D node2D = new Node2D();
        node2D.setName(StringNameUtils.asStringName(ravenNode2D.getNodeID()));
        Objects.requireNonNull(ravenNode2D.getParentNode()).addChild(node2D);
    }

    @Override
    public void visitGraphNode(RavenGraphNode ravenGraphNode) {
        System.out.println("Creating GraphNode");
        GraphNode graphNode = new GraphNode();
        graphNode.setName(StringNameUtils.asStringName(ravenGraphNode.getNodeID()));
        Objects.requireNonNull(ravenGraphNode.getParentNode()).addChild(graphNode);
    }

    @Override
    public void visitGraphEditNode(RavenGraphEditNode ravenGraphEditNode) {
        System.out.println("Creating GraphEditNode");
        GraphEdit graphEditNode = new GraphEdit();
        graphEditNode.setName(StringNameUtils.asStringName(ravenGraphEditNode.getNodeID()));
        Objects.requireNonNull(ravenGraphEditNode.getParentNode()).addChild(graphEditNode);
    }
}
