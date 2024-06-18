package cwi.masterthesis.raven.interpreter;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import cwi.masterthesis.raven.Main;
import cwi.masterthesis.raven.interpreter.mapper.stylingstrategy.StylingStrategy;
import cwi.masterthesis.raven.interpreter.nodes.RavenNode;
import cwi.masterthesis.raven.interpreter.nodes.RavenNode2D;
import cwi.masterthesis.raven.interpreter.nodes.StylingStrategyOverride;
import cwi.masterthesis.raven.interpreter.nodes.control.*;
import godot.*;
import godot.core.StringNameUtils;
import godot.core.Vector2;
import godot.global.GD;

import java.util.Iterator;
import java.util.Map;
import java.util.Objects;

// TODO: Some kind of builder to remove redundancy...
public class Interpreter extends Node implements Visitor {
    private static StylingStrategy strategy;
    private static Interpreter instance;

    private void applyStyling(RavenNode ravenNode, Control appendedClass) {
        if (ravenNode.getStyles() != null) {

            try {
                styleOverrideTraverser(ravenNode.getStyles(),appendedClass);
            } catch (JsonProcessingException e) {
                throw new RuntimeException(e);
            }
        }
    }
    private Interpreter(){}

    public static Interpreter getInstance() {
        if (instance == null) {
            instance = new Interpreter();
        }
        return instance;
    }


    @Override
    public void visitButton(RavenButton ravenButton)  {
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
       // System.out.println("Creating Label");
        Label label = new Label();
        label.setTheme(Main.mainTheme);
        label.setName(StringNameUtils.asStringName(ravenLabel.getNodeID()));
        label.setText(ravenLabel.getLabel());
        ravenLabel.getParentNode().addChild(label);
        applyStyling(ravenLabel, label);
    }

    @Override
    public void visitNode2D(RavenNode2D ravenNode2D) {
       // System.out.println("Creating Node2D");
        Node2D node2D = new Node2D();
        node2D.setName(StringNameUtils.asStringName(ravenNode2D.getNodeID()));
        Objects.requireNonNull(ravenNode2D.getParentNode()).addChild(node2D);
    }

    @Override
    public void visitGraphNode(RavenGraphNode ravenGraphNode) {
       // System.out.println("Creating GraphNode");
        GraphNode graphNode = new GraphNode();
        graphNode.setTheme(Main.mainTheme);
        graphNode.setName(StringNameUtils.asStringName(ravenGraphNode.getNodeID()));
        Objects.requireNonNull(ravenGraphNode.getParentNode()).addChild(graphNode);
    }

    @Override
    public void visitGraphEditNode(RavenGraphEditNode ravenGraphEditNode) {
       // System.out.println("Creating GraphEditNode");
        GraphEdit graphEditNode = new GraphEdit();
        graphEditNode.setTheme(Main.mainTheme);
        graphEditNode.setSize(new Vector2(500,600));
        graphEditNode.setName(StringNameUtils.asStringName(ravenGraphEditNode.getNodeID()));
        Objects.requireNonNull(ravenGraphEditNode.getParentNode()).addChild(graphEditNode);
    }

    @Override
    public void visitTextEdit(RavenTextEdit ravenTextEditNode) {
        //System.out.println("Creating TextEdit Node");
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
      //  System.out.println("Creating OptionButton");
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
       // System.out.println("Creating Panel");
        Panel panel = new Panel();
        panel.setTheme(Main.mainTheme);
        panel.setName(StringNameUtils.asStringName(ravenPanel.getName() == null ? ravenPanel.getNodeID() : ravenPanel.getName()));
        applyStyling(ravenPanel, panel);
        Objects.requireNonNull(ravenPanel.getParentNode()).addChild(panel);
    }

    @Override
    public void visitMarginContainer(RavenMarginContainer ravenMarginContainer) {
        //System.out.println("Creating MarginContainer");
        MarginContainer marginContainer = new MarginContainer();
        marginContainer.setTheme(Main.mainTheme);
        marginContainer.setName(StringNameUtils.asStringName(ravenMarginContainer.getName() == null ? ravenMarginContainer.getNodeID() : ravenMarginContainer.getName()));
        applyStyling(ravenMarginContainer, marginContainer);
        Objects.requireNonNull(ravenMarginContainer.getParentNode()).addChild(marginContainer);
    }

    @Override
    public void visitPanelContainer(RavenPanelContainer ravenPanelContainer) {
        //System.out.println("Creating PanelContainer");
        PanelContainer panelContainer = new PanelContainer();
        panelContainer.setTheme(Main.mainTheme);
        panelContainer.setName(StringNameUtils.asStringName(ravenPanelContainer.getName() == null ? ravenPanelContainer.getNodeID() : ravenPanelContainer.getName()));
        applyStyling(ravenPanelContainer, panelContainer);
        Objects.requireNonNull(ravenPanelContainer.getParentNode()).addChild(panelContainer);
    }

    @Override
    public void visitScrollContainer(RavenScrollContainer ravenScrollContainer) {
       // System.out.println("Creating ScrollContainer");
        ScrollContainer scrollContainer = new ScrollContainer();
        scrollContainer.setTheme(Main.mainTheme);
        scrollContainer.setName(StringNameUtils.asStringName(ravenScrollContainer.getName() == null ? ravenScrollContainer.getNodeID() : ravenScrollContainer.getName()));
        applyStyling(ravenScrollContainer, scrollContainer);
        Objects.requireNonNull(ravenScrollContainer.getParentNode()).addChild(scrollContainer);
    }

    @Override
    public void visitLineEdit(RavenLineEdit ravenLineEdit) {
      //  System.out.println("Creating LineEdit Node");
        ravenLineEdit.setTheme(Main.mainTheme);
        ravenLineEdit.setName(StringNameUtils.asStringName(ravenLineEdit.getNodeID()));
        ravenLineEdit.setText(ravenLineEdit.getTextContent());
        ravenLineEdit.set(StringNameUtils.asStringName("node_callback"), ravenLineEdit.getCallback());
        ravenLineEdit.setScript(GD.load("res://gdj/cwi/masterthesis/raven/scripts/LineEditScript.gdj"));
        applyStyling(ravenLineEdit, ravenLineEdit);
        Objects.requireNonNull(ravenLineEdit.getParentNode()).addChild(ravenLineEdit);
        ravenLineEdit.emitSignal(StringNameUtils.asStringName("line_init"), ravenLineEdit.getCallback());
    }

    @Override
    public void visitHBoxContainer(RavenHBoxContainer ravenHBoxContainer) {
        //System.out.println("Creating HBoxContainer");
        HBoxContainer hBoxContainer = new HBoxContainer();
        hBoxContainer.setTheme(Main.mainTheme);
        hBoxContainer.setName(StringNameUtils.asStringName(ravenHBoxContainer.getName() == null ? ravenHBoxContainer.getNodeID() : ravenHBoxContainer.getName()));
        applyStyling(ravenHBoxContainer, hBoxContainer);
        Objects.requireNonNull(ravenHBoxContainer.getParentNode()).addChild(hBoxContainer);
    }

    @Override
    public void visitVBoxContainer(RavenVBoxContainer ravenVBoxContainer) {
       // System.out.println("Creating VBoxContainer");
        VBoxContainer vBoxContainer = new VBoxContainer();
        vBoxContainer.setTheme(Main.mainTheme);
        vBoxContainer.setName(StringNameUtils.asStringName(ravenVBoxContainer.getNodeID()));
        applyStyling(ravenVBoxContainer, vBoxContainer);
        Objects.requireNonNull(ravenVBoxContainer.getParentNode()).addChild(vBoxContainer);
    }

    @Override
    public void visitGridContainer(RavenGridContainer ravenGridContainer) {
        //System.out.println("Creating Grid");
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
        //System.out.println("Creating Control");
        Control control = new Control();
        control.setTheme(Main.mainTheme);
        control.setName(StringNameUtils.asStringName(ravenControl.getNodeID()));
        applyStyling(ravenControl, control);
        Objects.requireNonNull(ravenControl.getParentNode()).addChild(control);
    }

    @Override
    public void visitTabContainer(RavenTabContainer ravenTabContainer) {
       // System.out.println("Creating TabContainer");
        TabContainer tabContainer = new TabContainer();
        ravenTabContainer.set(StringNameUtils.asStringName("node_callback"), ravenTabContainer.getCallback());
        tabContainer.setScript(GD.load("res://gdj/cwi/masterthesis/raven/scripts/TabContainerScript.gdj"));
        tabContainer.setTheme(Main.mainTheme);
        tabContainer.setName(StringNameUtils.asStringName(ravenTabContainer.getNodeID()));

        // Apparently the order matters here...
        applyStyling(ravenTabContainer, tabContainer);
        Objects.requireNonNull(ravenTabContainer.getParentNode()).addChild(tabContainer);
        tabContainer.emitSignal(StringNameUtils.asStringName("tab_init"), ravenTabContainer.getCallback());

    }

    public static void styleOverrideTraverser(String theme, Control node) throws JsonProcessingException {
        ObjectMapper mapper = new ObjectMapper();
        JsonNode elements = mapper.readTree(theme);
        StylingStrategyOverride themeOverride = new StylingStrategyOverride();

        for (JsonNode elem : elements) {
            String themeprop = elem.fieldNames().next();
            JsonNode valueContent = elem.get(themeprop);

            Iterator<Map.Entry<String, JsonNode>> fields = valueContent.fields();
            while (fields.hasNext()) {
                Map.Entry<String, JsonNode> entry = fields.next();
                StylingStrategy strategy = themeOverride.getStrategy(themeprop, node, entry);
                strategy.applyStyling();
            }
        }
    }


}
