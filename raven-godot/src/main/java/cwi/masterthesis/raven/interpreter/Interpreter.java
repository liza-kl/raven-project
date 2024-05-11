package cwi.masterthesis.raven.interpreter;

import cwi.masterthesis.raven.interpreter.nodes.RavenNode;
import cwi.masterthesis.raven.interpreter.nodes.RavenNode2D;
import cwi.masterthesis.raven.interpreter.nodes.control.*;
import godot.*;
import godot.core.StringNameUtils;
import godot.core.Vector2;
import godot.global.GD;

import java.util.Objects;

public class Interpreter extends Node implements Visitor {

    private void defaultSettings(Node instantiatedNode, RavenNode ravenNode) {
    }

    public void addChildren(Node child, Node parentNode) {
        parentNode.addChild(child);
    }

    @Override
    public void visitButton(RavenButton ravenButton)  {
        System.out.println("Creating Button");
        PackedScene DefaultButtonLook = GD.load("res://scenes/DefaultButton.tscn");
        Button button = (Button) DefaultButtonLook.instantiate();
        button.setText(ravenButton.getLabel());
        button.setName(StringNameUtils.asStringName(ravenButton.getNodeID()));
        button.setPosition(new Vector2(ravenButton.getXCoordinate(), ravenButton.getYCoordinate()));
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
        graphEditNode.setSize(new Vector2(500,600));
        graphEditNode.setName(StringNameUtils.asStringName(ravenGraphEditNode.getNodeID()));
        Objects.requireNonNull(ravenGraphEditNode.getParentNode()).addChild(graphEditNode);
    }

    @Override
    public void visitTextEditNode(RavenTextEdit ravenTextEditNode) {
        System.out.println("Creating TextEdit Node");
        TextEdit textEditNode = new TextEdit();
        textEditNode.setName(StringNameUtils.asStringName(ravenTextEditNode.getNodeID()));
        Objects.requireNonNull(ravenTextEditNode.getParentNode()).addChild(textEditNode);
    }

    @Override
    public void visitHBoxContainer(RavenHBoxContainer ravenHBoxContainer) {
        System.out.println("Creating HBoxContainer");
        HBoxContainer hBoxContainer = new HBoxContainer();
        hBoxContainer.setName(StringNameUtils.asStringName(ravenHBoxContainer.getNodeID()));
        Objects.requireNonNull(ravenHBoxContainer.getParentNode()).addChild(hBoxContainer);
    }

    @Override
    public void visitVBoxContainer(RavenVBoxContainer ravenVBoxContainer) {
        System.out.println("Creating VBoxContainer");
        VBoxContainer vBoxContainer = new VBoxContainer();
        vBoxContainer.setName(StringNameUtils.asStringName(ravenVBoxContainer.getNodeID()));
        Objects.requireNonNull(ravenVBoxContainer.getParentNode()).addChild(vBoxContainer);
    }

    @Override
    public void visitGrid(RavenGrid ravenGrid) {
        System.out.println("Creating Grid");
        GridContainer gridContainer = new GridContainer();
        gridContainer.setName(StringNameUtils.asStringName(ravenGrid.getNodeID()));
        Objects.requireNonNull(ravenGrid.getParentNode()).addChild(gridContainer);
    }

    @Override
    public void visitControl(RavenControl ravenControl) {
        System.out.println("Creating Control");
        Control control = new Control();
        control.setName(StringNameUtils.asStringName(ravenControl.getNodeID()));
        Objects.requireNonNull(ravenControl.getParentNode()).addChild(control);
    }
}
