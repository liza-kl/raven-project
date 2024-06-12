package cwi.masterthesis.raven.interpreter.nodes.control;

import cwi.masterthesis.raven.interpreter.Visitor;
import cwi.masterthesis.raven.interpreter.nodes.RavenNode;
import godot.Node;

public class RavenVBoxContainer implements RavenNode {
    private final String nodeID;
    private final Node parentNode;

    public RavenVBoxContainer(String nodeID, Node parentNode) {
        this.nodeID = nodeID;
        this.parentNode = parentNode;
    }


    @Override
    public String getNodeID() {
        return nodeID;
    }

    @Override
    public Node getParentNode() {
        return parentNode;
    }

    @Override
    public void acceptVisitor(Visitor visitor) {
        visitor.visitVBoxContainer(this);
    }

    @Override
    public String getStyles() {
        return "";
    }
}
