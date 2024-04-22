package cwi.masterthesis.raven.interpreter.nodes;

import cwi.masterthesis.raven.interpreter.Visitor;
import godot.Button;
import godot.Node;

public class RavenButton extends Button implements RavenNode {
    private Node parentNode;
    private String label;
    private int XCoordinate;
    private int YCoordinate;
    private String callback;

    public RavenButton(Node parentNode, String label, int XCoordinate, int YCoordinate, String callback) {
        this.parentNode = parentNode;
        this.label = label;
        this.XCoordinate = XCoordinate;
        this.YCoordinate = YCoordinate;
        this.callback = callback;

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

    public int getXCoordinate() {
        return XCoordinate;
    }

    public int getYCoordinate() {
        return YCoordinate;
    }

    public String getCallback() {
        return callback;
    }
}
