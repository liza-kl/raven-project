package cwi.masterthesis.raven.interpreter.nodes;

import cwi.masterthesis.raven.interpreter.Visitor;
import godot.Label;
import godot.Node;

public class RavenLabel extends Label implements RavenNode {
    private Node parentNode;
    private String label;
    private int XCoordinate;
    private int YCoordinate;

    public RavenLabel(Node parentNode, String label, int XCoordinate, int YCoordinate) {
        this.parentNode = parentNode;
        this.label = label;
        this.XCoordinate = XCoordinate;
        this.YCoordinate = YCoordinate;
    }

    @Override
    public void acceptVisitor(Visitor visitor) {
        visitor.visitLabel(this);

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

    public Node getParentNode() {
        return parentNode;
    }
}
