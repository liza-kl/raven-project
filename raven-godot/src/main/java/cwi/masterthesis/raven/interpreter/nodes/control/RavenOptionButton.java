package cwi.masterthesis.raven.interpreter.nodes.control;

import cwi.masterthesis.raven.interpreter.Visitor;
import cwi.masterthesis.raven.interpreter.nodes.RavenNode;
import godot.Node;

import java.util.ArrayList;

public class RavenOptionButton implements RavenNode {
    private final Node parentNode;
    private final String nodeID;
    private final ArrayList<String> options;

    private ArrayList<String> convertStringToList(String arr) {
        String trimmedInput = arr.substring(1, arr.length() - 1);
        String[] items = trimmedInput.split("\",\"");
        // Remove any remaining leading or trailing quotes from each item
        ArrayList<String> arrayList = new ArrayList<>();
        for (String item : items) {
            arrayList.add(item.replaceAll("^\"|\"$", ""));
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

    public ArrayList<String> getOptions() {
        return options;
    }

    @Override
    public void acceptVisitor(Visitor visitor) {
        visitor.visitOptionButton(this);
    }


}
