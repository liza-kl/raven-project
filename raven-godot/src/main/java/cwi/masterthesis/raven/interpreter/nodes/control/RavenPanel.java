package cwi.masterthesis.raven.interpreter.nodes.control;

import cwi.masterthesis.raven.interpreter.Visitor;
import cwi.masterthesis.raven.interpreter.nodes.RavenNode;
import godot.Node;

public class RavenPanel implements RavenNode {

    private final String nodeID;
    private final Node parentNode;
    private final String name;
    private final String styles;

    public RavenPanel(String nodeID, Node parentNode, String name, String styles) {
        this.nodeID = nodeID;
        this.parentNode = parentNode;
        this.name = name;
        this.styles = styles;
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
        visitor.visitPanel(this);
    }

    public String getName() {
        return name;
    }

    public String getStyles() {
        return styles;
    }
}
