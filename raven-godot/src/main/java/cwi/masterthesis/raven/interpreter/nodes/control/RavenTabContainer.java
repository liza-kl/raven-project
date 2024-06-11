package cwi.masterthesis.raven.interpreter.nodes.control;

import cwi.masterthesis.raven.interpreter.Visitor;
import cwi.masterthesis.raven.interpreter.nodes.RavenNode;
import godot.Node;
import godot.TabContainer;

public class RavenTabContainer extends TabContainer implements RavenNode {
    private  Node parentNode;
    private  String nodeID;
    private  String styles;
    private String callback;

    public RavenTabContainer() {
        super();
    }

    public RavenTabContainer(Node parentNode, String nodeID, String styles, String callback) {
        this.parentNode = parentNode;
        this.nodeID = nodeID;
        this.styles = styles;
        this.callback = callback;

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

    public String getStyles() {
        return styles;
    }

    public String getCallback() {
        return callback;
    }
}
