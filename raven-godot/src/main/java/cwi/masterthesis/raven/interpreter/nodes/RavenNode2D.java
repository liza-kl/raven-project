package cwi.masterthesis.raven.interpreter.nodes;

import cwi.masterthesis.raven.interpreter.Visitor;

public class RavenNode2D implements RavenNode {
    @Override
    public void acceptVisitor(Visitor visitor) {
        visitor.visitNode2D(this);
    }
}
