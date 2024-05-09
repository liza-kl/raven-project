package cwi.masterthesis.raven.interpreter.nodes;

import cwi.masterthesis.raven.interpreter.Visitor;
import godot.GraphEdit;
import godot.Node;

public class RavenGraphEditNode extends GraphEdit implements RavenNode {

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

    public Node getParentNode() {
        return parentNode;
    }

    public String getNodeID() {
        return nodeID;
    }
}
