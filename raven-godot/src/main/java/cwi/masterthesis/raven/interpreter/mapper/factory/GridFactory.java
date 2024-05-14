package cwi.masterthesis.raven.interpreter.mapper.factory;

import cwi.masterthesis.raven.interpreter.nodes.RavenNode;
import cwi.masterthesis.raven.interpreter.nodes.control.RavenGridContainer;
import godot.Node;

import java.util.Map;

public class GridFactory implements RavenNodeFactory {
    @Override
    public RavenNode createRavenNode(Node node, Map<String, String> attrMap) {
        return new RavenGridContainer(
                attrMap.get("id"),
                node,
                Integer.parseInt(attrMap.get("columns")),
                Integer.parseInt(attrMap.get("hSeparation")),
                Integer.parseInt(attrMap.get("vSeparation")),
                Integer.parseInt(attrMap.get("xPosition")),
                Integer.parseInt(attrMap.get("yPosition")));
    }

}
