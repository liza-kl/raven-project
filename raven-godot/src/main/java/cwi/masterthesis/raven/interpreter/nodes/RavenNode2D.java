package cwi.masterthesis.raven.interpreter.nodes;

import cwi.masterthesis.raven.interpreter.Visitor;
import godot.Node;
import godot.Node2D;

public class RavenNode2D extends Node2D implements RavenNode {
    private final Node parentNode;
    private final String nodeID;
    public RavenNode2D(Node parentNode, String nodeID) {
        this.parentNode = parentNode;
        this.nodeID = nodeID;

    }
    @Override
    public void acceptVisitor(Visitor visitor) {
        visitor.visitNode2D(this);
    }

    @Override
    public String getStyles() {
        return "";
    }

    public String getNodeID() {
        return nodeID;
    }

    public Node getParentNode() {
        return parentNode;
    }
}
