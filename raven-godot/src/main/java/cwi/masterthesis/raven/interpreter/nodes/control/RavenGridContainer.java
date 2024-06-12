package cwi.masterthesis.raven.interpreter.nodes.control;

import cwi.masterthesis.raven.interpreter.Visitor;
import cwi.masterthesis.raven.interpreter.nodes.RavenNode;
import godot.Node;

public class RavenGridContainer implements RavenNode {
    private final String nodeID;
    private final Node parentNode;
    private  final Integer columns;
    private  final Integer hSeparation;
    private  final Integer vSeparation;
    private final Integer  xPosition;
    private final Integer  yPosition;

    /**
     * @param nodeID ID of the node (usually node name)
     * @param parentNode  Where should this node be appended to
     * @param columns How many columns should the grid have
     * @param hSeparation The horizontal separation of the children
     * @param vSeparation The vertical separation of the children
     * @param xPosition Position of the Grid
     * @param yPosition Position of the Grid
     */
    public RavenGridContainer(String nodeID,
                              Node parentNode,
                              Integer columns,
                              Integer hSeparation,
                              Integer vSeparation,
                              Integer xPosition,
                              Integer yPosition) {
        this.nodeID = nodeID;
        this.parentNode = parentNode;
        this.columns = columns;
        this.hSeparation = hSeparation;
        this.vSeparation = vSeparation;
        this.xPosition = xPosition;
        this.yPosition = yPosition;
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
        visitor.visitGridContainer(this);
    }

    @Override
    public String getStyles() {
        return "";
    }

    public Integer getColumns() {
        return columns;
    }

    public Integer gethSeparation() {
        return hSeparation;
    }

    public Integer getvSeparation() {
        return vSeparation;
    }

    public Integer getxPosition() {
        return xPosition;
    }

    public Integer getyPosition() {
        return yPosition;
    }
}
