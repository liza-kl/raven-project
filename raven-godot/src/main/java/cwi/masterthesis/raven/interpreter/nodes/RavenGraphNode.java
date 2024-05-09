package cwi.masterthesis.raven.interpreter.nodes;

import cwi.masterthesis.raven.interpreter.Visitor;
import godot.Node;

public class RavenGraphNode implements RavenNode {


    private final Node parentNode;
    private final String nodeID;

    public RavenGraphNode(Node parentNode, String nodeID) {
        this.parentNode = parentNode;
        this.nodeID = nodeID;
    }

    @Override
    public void acceptVisitor(Visitor visitor) {
        visitor.visitGraphNode(this);
    }

    public Node getParentNode() {
        return parentNode;
    }

    public String getNodeID() {
        return nodeID;
    }
}
