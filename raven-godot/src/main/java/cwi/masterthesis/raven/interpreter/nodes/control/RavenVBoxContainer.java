package cwi.masterthesis.raven.interpreter.nodes.control;

import cwi.masterthesis.raven.interpreter.Visitor;
import cwi.masterthesis.raven.interpreter.nodes.RavenNode;
import godot.Node;

public class RavenVBoxContainer implements RavenNode {
    @Override
    public String getNodeID() {
        return "";
    }

    @Override
    public Node getParentNode() {
        return null;
    }

    @Override
    public void acceptVisitor(Visitor visitor) {

    }
}
