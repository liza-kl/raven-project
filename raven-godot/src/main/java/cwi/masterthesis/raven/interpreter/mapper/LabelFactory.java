package cwi.masterthesis.raven.interpreter.mapper;

import cwi.masterthesis.raven.interpreter.nodes.RavenLabel;
import cwi.masterthesis.raven.interpreter.nodes.RavenNode;
import godot.Node;

import java.util.Map;

public class LabelFactory implements RavenNodeFactory {
    @Override
    public RavenNode createRavenNode(Node mainRavenNode, Map<String, String> attrMap) {
        return new RavenLabel(
                mainRavenNode,
                attrMap.get("text"),
                Integer.parseInt(attrMap.get("xPosition")),
                Integer.parseInt(attrMap.get("yPosition")));
    }
}