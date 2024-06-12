package cwi.masterthesis.raven.interpreter.nodes.control;

import cwi.masterthesis.raven.interpreter.Visitor;
import cwi.masterthesis.raven.interpreter.nodes.RavenNode;
import godot.Node;

public class RavenGraphEditNode implements RavenNode {

    private final String nodeID;
    private final Node parentNode;

    public RavenGraphEditNode(String nodeID, Node parentNode) {
        this.nodeID = nodeID;
        this.parentNode = parentNode;
    }

    @Override
    public void acceptVisitor(Visitor visitor) {
        visitor.visitGraphEditNode(this);

    }

    @Override
    public String getStyles() {
        return "";
    }

    public Node getParentNode() {
        return parentNode;
    }

    public String getNodeID() {
        return nodeID;
    }
}
