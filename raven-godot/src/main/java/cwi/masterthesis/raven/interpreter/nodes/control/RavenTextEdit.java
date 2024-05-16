package cwi.masterthesis.raven.interpreter.nodes.control;

import cwi.masterthesis.raven.interpreter.Visitor;
import cwi.masterthesis.raven.interpreter.nodes.RavenNode;
import godot.Node;
import godot.TextEdit;
import godot.annotation.Export;
import godot.annotation.RegisterClass;
import godot.annotation.RegisterProperty;

@RegisterClass
public class RavenTextEdit extends TextEdit implements RavenNode {
    private String nodeID;
    private Node parentNode;
    private String text;
    private String callback;

    @Export
    @RegisterProperty
    public String nodeCallback;

    public RavenTextEdit(String nodeID, Node parentNode, String text, String callback) {
        this.nodeID = nodeID;
        this.parentNode = parentNode;
        this.text = text;
        this.callback = callback;
        nodeCallback = callback;
    }

    public RavenTextEdit() {
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
        visitor.visitTextEdit(this);
    }

    public String getTextContent() {
        return text;
    }

    public String getCallback() {
        return callback;
    }
}
