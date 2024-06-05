package cwi.masterthesis.raven.interpreter.nodes.control;

import cwi.masterthesis.raven.interpreter.Visitor;
import cwi.masterthesis.raven.interpreter.nodes.RavenNode;
import godot.Button;
import godot.Node;
import godot.annotation.RegisterClass;

@RegisterClass
public class RavenButton extends Button implements RavenNode {
    private String nodeID;
    private Node parentNode;
    private String label;

    private String callback;
    private String styles;


    public RavenButton() {
        super();
    }

    // TODO make this somehow dynamic
    public RavenButton(String nodeID, Node parentNode, String label, String callback, String styles) {
        this.nodeID = nodeID;
        this.parentNode = parentNode;
        this.label = label;
        this.callback = callback;
        this.styles = styles;
    }


    @Override
    public void acceptVisitor(Visitor visitor) {
        visitor.visitButton(this);
    }

    public Node getParentNode() {
        return parentNode;
    }

    public String getLabel() {
        return label;
    }
    public String getCallback() {
        return callback;
    }
    public String getNodeID() {
        return nodeID;
    }

    public String getStyles() {
        return this.styles;
    }
}
