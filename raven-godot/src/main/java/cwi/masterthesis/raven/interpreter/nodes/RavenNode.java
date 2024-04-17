package cwi.masterthesis.raven.interpreter.nodes;

import cwi.masterthesis.raven.interpreter.Visitor;

public interface RavenNode {
    void acceptVisitor(Visitor visitor);
}
