package cwi.masterthesis.raven.interpreter.nodes.control;

import cwi.masterthesis.raven.interpreter.Visitor;
import cwi.masterthesis.raven.interpreter.nodes.RavenNode;
import godot.Node;
import godot.OptionButton;
import godot.annotation.Export;
import godot.annotation.RegisterClass;
import godot.annotation.RegisterProperty;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@RegisterClass
public class RavenOptionButton extends OptionButton implements RavenNode {
    private  Node parentNode;
    private  String nodeID;
    private  List<String> options;
    private  String callback;
    private  String styles;


    @Export
    @RegisterProperty
    public String nodeCallback;

    public RavenOptionButton(Node parentNode, String nodeID, String options, String callback, String styles) {
        this.parentNode = parentNode;
        this.nodeID = nodeID;
        this.options = convertStringToList(options);
        this.callback = callback;
        nodeCallback = callback;
        this.styles = styles;
    }

    public RavenOptionButton() {
        super();
    }
    private List<String> convertStringToList(String arr) {
        // If you do not have any options at all.
        if (arr == null) {
            return List.of();
        }
        String cleaned = arr.replaceAll("^\\[", "").replaceAll("]$", "");

        // Split the string by ","
        List<String> items = Arrays.asList(cleaned.split("\\s*,\\s*"));

        // Remove any remaining leading or trailing quotes from each item
        List<String> arrayList = new ArrayList<>();
        for (String item : items) {
            arrayList.add(item.replaceAll("[\"\\s]+", "").trim());
        }
        return arrayList;
    }



    @Override
    public String getNodeID() {
        return this.nodeID;
    }

    @Override
    public Node getParentNode() {
        return this.parentNode;

    }

    public List<String> getOptions() {
        return options;
    }

    @Override
    public void acceptVisitor(Visitor visitor) {
        visitor.visitOptionButton(this);
    }


    public String getCallback() {
        return callback;
    }

    public String getStyles() {
        return styles;
    }
}
