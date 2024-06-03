package cwi.masterthesis.raven.interpreter.nodes.control;

import cwi.masterthesis.raven.interpreter.Visitor;
import cwi.masterthesis.raven.interpreter.nodes.RavenNode;
import godot.Node;

public class RavenLabel implements RavenNode {
    private final String nodeID;
    private final Node parentNode;
    private final String label;
    private final int XCoordinate;
    private final int YCoordinate;
    private final String styles;

    public RavenLabel(String nodeID, Node parentNode, String label, String styles, int XCoordinate, int YCoordinate) {
        this.nodeID = nodeID;
        this.parentNode = parentNode;
        this.label = label;
        this.XCoordinate = XCoordinate;
        this.YCoordinate = YCoordinate;
        this.styles = styles;
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

    public String getNodeID() {
        return nodeID;
    }

    public String getStyles() {
        return styles;
    }
}
