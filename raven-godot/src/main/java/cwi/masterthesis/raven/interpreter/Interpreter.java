package cwi.masterthesis.raven.interpreter;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import cwi.masterthesis.raven.Main;
import cwi.masterthesis.raven.interpreter.mapper.stylingstrategy.*;
import cwi.masterthesis.raven.interpreter.nodes.RavenNode;
import cwi.masterthesis.raven.interpreter.nodes.RavenNode2D;
import cwi.masterthesis.raven.interpreter.nodes.control.*;
import godot.*;
import godot.core.StringNameUtils;
import godot.core.Vector2;
import godot.global.GD;

import java.lang.Object;
import java.util.Iterator;
import java.util.Map;
import java.util.Objects;

// TODO: Some kind of builder to remove redundancy...
public class Interpreter extends Node implements Visitor {
    private static StylingStrategy strategy;

    private void initDefault() {
        // TODO: Get classname from raven name and init it.
    }

    private void applyStyling(RavenNode ravenNode, Control appendedClass) {
        if (ravenNode.getStyles() != null) {

            try {
                styleOverrideTraverser(ravenNode.getStyles(),appendedClass);
            } catch (JsonProcessingException e) {
                throw new RuntimeException(e);
            }
        }
    }
    @Override
    public void visitButton(RavenButton ravenButton)  {
        System.out.println("Creating Button");
      //  PackedScene DefaultButtonLook = GD.load("res://scenes/DefaultButton.tscn");
        Button button = new Button();
        button.setTheme(Main.mainTheme);


        button.setText(ravenButton.getLabel());
        button.setName(StringNameUtils.asStringName(ravenButton.getNodeID()));
        button.set(StringNameUtils.asStringName("btn_id"), ravenButton.getNodeID());
        button.set(StringNameUtils.asStringName("btn_callback"), ravenButton.getCallback());
        button.setScript(GD.load("res://gdj/cwi/masterthesis/raven/scripts/ButtonSendMessage.gdj"));
        ravenButton.getParentNode().addChild(button);
        applyStyling(ravenButton, button);
        button.emitSignal(StringNameUtils.asStringName("button_init"), ravenButton.getCallback());
    }

    @Override
    public void visitLabel(RavenLabel ravenLabel) {
        System.out.println("Creating Label");
        Label label = new Label();
        label.setTheme(Main.mainTheme);
        label.setName(StringNameUtils.asStringName(ravenLabel.getNodeID()));
        label.setText(ravenLabel.getLabel());
        ravenLabel.getParentNode().addChild(label);
        applyStyling(ravenLabel, label);
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
       //ravenTextEditNode.setCustomMinimumSize(new Vector2(200,100));
        ravenTextEditNode.setTheme(Main.mainTheme);
        ravenTextEditNode.setName(StringNameUtils.asStringName(ravenTextEditNode.getNodeID()));
        ravenTextEditNode.setText(ravenTextEditNode.getTextContent());
        ravenTextEditNode.set(StringNameUtils.asStringName("node_callback"), ravenTextEditNode.getCallback());
        ravenTextEditNode.setScript(GD.load("res://gdj/cwi/masterthesis/raven/scripts/TextEditScript.gdj"));
        Objects.requireNonNull(ravenTextEditNode.getParentNode()).addChild(ravenTextEditNode);
        applyStyling(ravenTextEditNode, ravenTextEditNode);
        ravenTextEditNode.emitSignal(StringNameUtils.asStringName("text_init"), ravenTextEditNode.getCallback());
    }

    @Override
    public void visitOptionButton(RavenOptionButton ravenOptionButton) {
        System.out.println("Creating OptionButton");
        ravenOptionButton.setTheme(Main.mainTheme);
        ravenOptionButton.setName(StringNameUtils.asStringName(ravenOptionButton.getNodeID()));
        ravenOptionButton.set(StringNameUtils.asStringName("node_callback"), ravenOptionButton.getCallback());
        ravenOptionButton.setScript(GD.load("res://gdj/cwi/masterthesis/raven/scripts/OptionButtonScript.gdj"));
        ravenOptionButton.getOptions().forEach(ravenOptionButton::addItem);
        ravenOptionButton.getParentNode().addChild(ravenOptionButton);
        applyStyling(ravenOptionButton, ravenOptionButton);
        ravenOptionButton.emitSignal(StringNameUtils.asStringName("option_init"), ravenOptionButton.getCallback());
    }


    @Override
    public void visitPanel(RavenPanel ravenPanel) {
        System.out.println("Creating Panel");
        Panel panel = new Panel();
        panel.setSizeFlagsHorizontal(Control.SizeFlags.Companion.getSIZE_EXPAND_FILL());
        panel.setSizeFlagsVertical(Control.SizeFlags.Companion.getSIZE_EXPAND_FILL());
        panel.setTheme(Main.mainTheme);
        panel.setName(StringNameUtils.asStringName(ravenPanel.getName() == null ? ravenPanel.getNodeID() : ravenPanel.getName()));
        Objects.requireNonNull(ravenPanel.getParentNode()).addChild(panel);
        applyStyling(ravenPanel, panel);
    }

    @Override
    public void visitPanelContainer(RavenPanelContainer ravenPanelContainer) {
        System.out.println("Creating PanelContainer");
        PanelContainer panelContainer = new PanelContainer();
        panelContainer.setSizeFlagsHorizontal(Control.SizeFlags.Companion.getSIZE_EXPAND_FILL());
        panelContainer.setSizeFlagsVertical(Control.SizeFlags.Companion.getSIZE_EXPAND_FILL());
        panelContainer.setTheme(Main.mainTheme);
        panelContainer.setName(StringNameUtils.asStringName(ravenPanelContainer.getName() == null ? ravenPanelContainer.getNodeID() : ravenPanelContainer.getName()));
        Objects.requireNonNull(ravenPanelContainer.getParentNode()).addChild(panelContainer);
        applyStyling(ravenPanelContainer, panelContainer);
    }

    @Override
    public void visitScrollContainer(RavenScrollContainer ravenScrollContainer) {
        System.out.println("Creating ScrollContainer");
        PackedScene DefaultTabContainer = GD.load("res://scenes/DefaultScrollContainer.tscn");
        ScrollContainer scrollContainer = (ScrollContainer) DefaultTabContainer.instantiate();
        scrollContainer.setSizeFlagsHorizontal(Control.SizeFlags.Companion.getSIZE_EXPAND_FILL());
        scrollContainer.setSizeFlagsVertical(Control.SizeFlags.Companion.getSIZE_EXPAND_FILL());
        scrollContainer.setTheme(Main.mainTheme);
        scrollContainer.setName(StringNameUtils.asStringName(ravenScrollContainer.getName() == null ? ravenScrollContainer.getNodeID() : ravenScrollContainer.getName()));
        Objects.requireNonNull(ravenScrollContainer.getParentNode()).addChild(scrollContainer);
        scrollContainer.setSizeFlagsVertical(Control.SizeFlags.Companion.getSIZE_EXPAND_FILL());
        applyStyling(ravenScrollContainer, scrollContainer);

    }

    @Override
    public void visitLineEdit(RavenLineEdit ravenLineEdit) {
        System.out.println("Creating LineEdit Node");
        ravenLineEdit.setTheme(Main.mainTheme);
        ravenLineEdit.setName(StringNameUtils.asStringName(ravenLineEdit.getNodeID()));
        ravenLineEdit.setText(ravenLineEdit.getTextContent());
        ravenLineEdit.set(StringNameUtils.asStringName("node_callback"), ravenLineEdit.getCallback());
        ravenLineEdit.setScript(GD.load("res://gdj/cwi/masterthesis/raven/scripts/LineEditScript.gdj"));
        Objects.requireNonNull(ravenLineEdit.getParentNode()).addChild(ravenLineEdit);
        ravenLineEdit.emitSignal(StringNameUtils.asStringName("line_init"), ravenLineEdit.getCallback());
    }

    @Override
    public void visitHBoxContainer(RavenHBoxContainer ravenHBoxContainer) {
        System.out.println("Creating HBoxContainer");
        // TODO in the end one could provide custom scenes? In a Configuration?
        PackedScene DefaultTabContainer = GD.load("res://scenes/DefaultHBoxContainer.tscn");
        HBoxContainer hBoxContainer = (HBoxContainer) DefaultTabContainer.instantiate();
        hBoxContainer.setSizeFlagsHorizontal(Control.SizeFlags.Companion.getSIZE_EXPAND_FILL());
        hBoxContainer.setSizeFlagsVertical(Control.SizeFlags.Companion.getSIZE_EXPAND_FILL());
        hBoxContainer.setTheme(Main.mainTheme);
        hBoxContainer.setName(StringNameUtils.asStringName(ravenHBoxContainer.getName() == null ? ravenHBoxContainer.getNodeID() : ravenHBoxContainer.getName()));
        Objects.requireNonNull(ravenHBoxContainer.getParentNode()).addChild(hBoxContainer);
        applyStyling(ravenHBoxContainer, hBoxContainer);
    }

    @Override
    public void visitVBoxContainer(RavenVBoxContainer ravenVBoxContainer) {
        System.out.println("Creating VBoxContainer");
        PackedScene DefaultVBoxContainer = GD.load("res://scenes/DefaultVBoxContainer.tscn");
        VBoxContainer vBoxContainer = (VBoxContainer) DefaultVBoxContainer.instantiate();
        vBoxContainer.setSizeFlagsHorizontal(Control.SizeFlags.Companion.getSIZE_EXPAND_FILL());
        vBoxContainer.setSizeFlagsVertical(Control.SizeFlags.Companion.getSIZE_EXPAND_FILL());
        vBoxContainer.setTheme(Main.mainTheme);
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
        if (ravenTabContainer.getStyles() != null) {

            try {
                styleOverrideTraverser(ravenTabContainer.getStyles(),tabContainer);
            } catch (JsonProcessingException e) {
                throw new RuntimeException(e);
            }
        }
    }


    public static void styleOverrideTraverser(String theme, Control node) throws JsonProcessingException {
        ObjectMapper mapper = new ObjectMapper();
        JsonNode elements = mapper.readTree(theme);
        for (JsonNode elem : elements) {
                String themeprop = elem.fieldNames().next();
                JsonNode valueContent = elem.get(themeprop);

                Iterator<Map.Entry<String, JsonNode>> fields = valueContent.fields();
                while (fields.hasNext()) {
                    Map.Entry<String, JsonNode> entry = fields.next();
                    // TODO: Some switch expression / mapping to increase traverse performance
                    // TODO: Dummy values for now.
                    if (themeprop.equals("Godot")) {
                        strategy = new GodotOverrideStrategy(node, entry.getKey(), entry.getKey());
                    }
                    if(themeprop.equals("Vector2")) {
                        strategy = new Vector2OverrideStrategy(node, entry.getKey(), entry.getValue().asInt(), entry.getValue().asInt());
                    }
                    if (themeprop.equals("Primitive")) {
                        strategy = new PrimitiveOverrideStrategy(node, entry.getKey(),entry.getValue().asText());
                    }
                    if (themeprop.equals("Color")) {
                        strategy = new ColorOverrideStrategy(node, entry.getKey(),entry.getValue().asText());
                    }
                    if (themeprop.equals("FontSize")) {
                        strategy = new FontSizeOverrideStrategy(node, entry.getKey(),entry.getValue().asInt());
                    }
                    if (themeprop.equals("StyleBoxFlat")) {
                        Map<String, Object> result = mapper.convertValue(entry.getValue(), new TypeReference<>() {
                        });
                        strategy = new StyleBoxFlatOverrideStrategy(node, entry.getKey(), result);
                    }
                    strategy.applyStyling();

                }
            }
        }


}
