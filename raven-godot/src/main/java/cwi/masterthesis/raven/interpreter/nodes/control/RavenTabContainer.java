package cwi.masterthesis.raven.interpreter.nodes.control;

import cwi.masterthesis.raven.interpreter.Visitor;
import cwi.masterthesis.raven.interpreter.nodes.RavenNode;
import godot.Node;

public class RavenTabContainer implements RavenNode {
    private final Node parentNode;
    private final String nodeID;
    public RavenTabContainer(Node parentNode, String nodeID) {
        this.parentNode = parentNode;
        this.nodeID = nodeID;
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
        visitor.visitTabContainer(this);
    }
}
