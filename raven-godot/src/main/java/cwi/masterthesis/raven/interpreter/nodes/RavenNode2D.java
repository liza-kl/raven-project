package cwi.masterthesis.raven.interpreter.nodes;

import cwi.masterthesis.raven.interpreter.Visitor;
import godot.Node2D;

public class RavenNode2D extends Node2D implements RavenNode {

    @Override
    public void acceptVisitor(Visitor visitor) {
        visitor.visitNode2D(this);
    }
}
