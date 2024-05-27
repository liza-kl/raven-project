package cwi.masterthesis.raven.interpreter;

import cwi.masterthesis.raven.Main;
import cwi.masterthesis.raven.interpreter.nodes.RavenNode2D;
import cwi.masterthesis.raven.interpreter.nodes.control.*;
import godot.*;
import godot.core.StringNameUtils;
import godot.core.Vector2;
import godot.global.GD;

import java.util.Objects;

public class Interpreter extends Node implements Visitor {

    @Override
    public void visitButton(RavenButton ravenButton)  {
        System.out.println("Creating Button");
      //  PackedScene DefaultButtonLook = GD.load("res://scenes/DefaultButton.tscn");
        Button button = new Button();
        button.setTheme(Main.mainTheme);
        button.setText(ravenButton.getLabel());
        button.setName(StringNameUtils.asStringName(ravenButton.getNodeID()));
        button.setPosition(new Vector2(ravenButton.getXCoordinate(), ravenButton.getYCoordinate()));
        button.set(StringNameUtils.asStringName("btn_id"), ravenButton.getNodeID());
        button.set(StringNameUtils.asStringName("btn_callback"), ravenButton.getCallback());
        button.setScript(GD.load("res://gdj/cwi/masterthesis/raven/scripts/ButtonSendMessage.gdj"));
        ravenButton.getParentNode().addChild(button);
        button.emitSignal(StringNameUtils.asStringName("button_init"), ravenButton.getCallback());
    }

    @Override
    public void visitLabel(RavenLabel ravenLabel) {
        System.out.println("Creating Label");
        Label label = new Label();
        label.setTheme(Main.mainTheme);
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
        graphNode.setTheme(Main.mainTheme);
        graphNode.setName(StringNameUtils.asStringName(ravenGraphNode.getNodeID()));
        Objects.requireNonNull(ravenGraphNode.getParentNode()).addChild(graphNode);
    }

    @Override
    public void visitGraphEditNode(RavenGraphEditNode ravenGraphEditNode) {
        System.out.println("Creating GraphEditNode");
        GraphEdit graphEditNode = new GraphEdit();
        graphEditNode.setTheme(Main.mainTheme);
        graphEditNode.setSize(new Vector2(500,600));
        graphEditNode.setName(StringNameUtils.asStringName(ravenGraphEditNode.getNodeID()));
        Objects.requireNonNull(ravenGraphEditNode.getParentNode()).addChild(graphEditNode);
    }

    @Override
    public void visitTextEdit(RavenTextEdit ravenTextEditNode) {
        System.out.println("Creating TextEdit Node");
        ravenTextEditNode.setCustomMinimumSize(new Vector2(300,200));
        ravenTextEditNode.setTheme(Main.mainTheme);
        ravenTextEditNode.setName(StringNameUtils.asStringName(ravenTextEditNode.getNodeID()));
        ravenTextEditNode.setText(ravenTextEditNode.getTextContent());
        ravenTextEditNode.set(StringNameUtils.asStringName("node_callback"), ravenTextEditNode.getCallback());
        ravenTextEditNode.setScript(GD.load("res://gdj/cwi/masterthesis/raven/scripts/TextEditScript.gdj"));
        Objects.requireNonNull(ravenTextEditNode.getParentNode()).addChild(ravenTextEditNode);
        ravenTextEditNode.emitSignal(StringNameUtils.asStringName("text_init"), ravenTextEditNode.getCallback());
    }

    @Override
    public void visitHBoxContainer(RavenHBoxContainer ravenHBoxContainer) {
        System.out.println("Creating HBoxContainer");
        // TODO in the end one could provide custom scenes? In a Configuration?
        PackedScene DefaultTabContainer = GD.load("res://scenes/DefaultHBoxContainer.tscn");
        HBoxContainer hBoxContainer = (HBoxContainer) DefaultTabContainer.instantiate();
        hBoxContainer.setTheme(Main.mainTheme);
        hBoxContainer.setName(StringNameUtils.asStringName(ravenHBoxContainer.getName() == null ? ravenHBoxContainer.getNodeID() : ravenHBoxContainer.getName()));
        Objects.requireNonNull(ravenHBoxContainer.getParentNode()).addChild(hBoxContainer);
    }

    @Override
    public void visitVBoxContainer(RavenVBoxContainer ravenVBoxContainer) {
        System.out.println("Creating VBoxContainer");
        VBoxContainer vBoxContainer = new VBoxContainer();
        vBoxContainer.setTheme(Main.mainTheme);
        vBoxContainer.setSizeFlagsHorizontal(Control.SizeFlags.Companion.getSIZE_EXPAND_FILL());
        vBoxContainer.setSizeFlagsVertical(Control.SizeFlags.Companion.getSIZE_EXPAND_FILL());
        vBoxContainer.setName(StringNameUtils.asStringName(ravenVBoxContainer.getNodeID()));
        Objects.requireNonNull(ravenVBoxContainer.getParentNode()).addChild(vBoxContainer);
    }

    @Override
    public void visitGridContainer(RavenGridContainer ravenGridContainer) {
        System.out.println("Creating Grid");
        GridContainer gridContainer = new GridContainer();
        gridContainer.setTheme(Main.mainTheme);

        gridContainer.setName(StringNameUtils.asStringName(ravenGridContainer.getNodeID()));
        gridContainer.setColumns(ravenGridContainer.getColumns());
        gridContainer.setPosition(new Vector2(ravenGridContainer.getxPosition(), ravenGridContainer.getyPosition()));
        gridContainer.set(StringNameUtils.asStringName("h_separation"), ravenGridContainer.gethSeparation());
        gridContainer.set(StringNameUtils.asStringName("v_separation"), ravenGridContainer.getvSeparation());
        Objects.requireNonNull(ravenGridContainer.getParentNode()).addChild(gridContainer);
    }

    @Override
    public void visitControl(RavenControl ravenControl) {
        System.out.println("Creating Control");
        Control control = new Control();
        control.setTheme(Main.mainTheme);
        control.setName(StringNameUtils.asStringName(ravenControl.getNodeID()));
        Objects.requireNonNull(ravenControl.getParentNode()).addChild(control);
    }

    @Override
    public void visitTabContainer(RavenTabContainer ravenTabContainer) {
        System.out.println("Creating TabContainer");
        // TODO everyone could just customize this I guess.

        PackedScene DefaultTabContainer = GD.load("res://scenes/DefaultTabContainer.tscn");
        TabContainer tabContainer = (TabContainer) DefaultTabContainer.instantiate();
        tabContainer.setTheme(Main.mainTheme);
        tabContainer.setClipTabs(false);
        tabContainer.setName(StringNameUtils.asStringName(ravenTabContainer.getNodeID()));
        Objects.requireNonNull(ravenTabContainer.getParentNode()).addChild(tabContainer);
    }

    @Override
    public void visitOptionButton(RavenOptionButton ravenOptionButton) {
        System.out.println("Creating OptionButton");
        OptionButton optionButton = new OptionButton();
        optionButton.setTheme(Main.mainTheme);
        optionButton.setName(StringNameUtils.asStringName(ravenOptionButton.getNodeID()));
        ravenOptionButton.getOptions().forEach(optionButton::addItem);
        ravenOptionButton.getParentNode().addChild(optionButton);
    }
}
