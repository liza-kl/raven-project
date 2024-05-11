package cwi.masterthesis.raven.interpreter.nodes;

import cwi.masterthesis.raven.interpreter.Visitor;
import godot.Node;

public interface RavenNode {
    String getNodeID();
    Node getParentNode();
    void acceptVisitor(Visitor visitor);
}
