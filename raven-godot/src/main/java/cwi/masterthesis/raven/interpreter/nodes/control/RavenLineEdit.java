package cwi.masterthesis.raven.interpreter.nodes.control;

import cwi.masterthesis.raven.interpreter.Visitor;
import cwi.masterthesis.raven.interpreter.nodes.RavenNode;
import godot.LineEdit;
import godot.Node;
import godot.annotation.Export;
import godot.annotation.RegisterClass;
import godot.annotation.RegisterProperty;

@RegisterClass
public class RavenLineEdit extends LineEdit implements RavenNode {
    private String nodeID;
    private Node parentNode;
    private String text;
    private String callback;
    private String styles;

    @Export
    @RegisterProperty
    public String nodeCallback;

    public RavenLineEdit(String nodeID, Node parentNode, String text, String callback, String styles) {
        this.nodeID = nodeID;
        this.parentNode = parentNode;
        this.text = text;
        this.callback = callback;
        nodeCallback = callback;
        this.styles = styles;
    }

    public RavenLineEdit() {
        super();
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
        visitor.visitLineEdit(this);
    }

    @Override
    public String getStyles() {
        return this.styles;
    }

    public String getTextContent() {
        return this.text;
    }

    public String getCallback() {
        return this.callback;
    }
}