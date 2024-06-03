package cwi.masterthesis.raven.interpreter.nodes.control;

import cwi.masterthesis.raven.interpreter.Visitor;
import cwi.masterthesis.raven.interpreter.nodes.RavenNode;
import godot.Node;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class RavenOptionButton implements RavenNode {
    private final Node parentNode;
    private final String nodeID;
    private final List<String> options;

    private List<String> convertStringToList(String arr) {

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

    public RavenOptionButton(Node parentNode, String nodeID, String options) {
        this.parentNode = parentNode;
        this.nodeID = nodeID;
        this.options = convertStringToList(options);
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


}
