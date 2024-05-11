package cwi.masterthesis.raven.interpreter.nodes.control;

import cwi.masterthesis.raven.interpreter.Visitor;
import cwi.masterthesis.raven.interpreter.nodes.RavenNode;
import godot.Node;

public class RavenGrid implements RavenNode {
    private final String nodeID;
    private final Node parentNode;

    public RavenGrid(String nodeID, Node parentNode) {
        this.nodeID = nodeID;
        this.parentNode = parentNode;
    }

    @Override
    public String getNodeID() {
        return this.nodeID;
    }

    @Override
    public Node getParentNode() {
        return this.parentNode;
    }

    @Override
    public void acceptVisitor(Visitor visitor) {
        visitor.visitGrid(this);
    }
}
