package cwi.masterthesis.raven.interpreter.nodes;

import cwi.masterthesis.raven.interpreter.Visitor;
import godot.Node;
import godot.Node2D;

public class RavenNode2D extends Node2D implements RavenNode {
    private Node parentNode;
    public RavenNode2D(Node parentNode) {
        this.parentNode = parentNode;

    }
    @Override
    public void acceptVisitor(Visitor visitor) {
        visitor.visitNode2D(this);
    }
}
