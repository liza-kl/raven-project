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
    private int XCoordinate;
    private int YCoordinate;
    private String callback;
    private String styles;


    public RavenButton() {
        super();
    }

    // TODO make this somehow dynamic
    public RavenButton(String nodeID, Node parentNode, String label, int XCoordinate, int YCoordinate, String callback, String styles) {
        this.nodeID = nodeID;
        this.parentNode = parentNode;
        this.label = label;
        this.XCoordinate = XCoordinate;
        this.YCoordinate = YCoordinate;
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

    public int getXCoordinate() {
        return XCoordinate;
    }

    public int getYCoordinate() {
        return YCoordinate;
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
