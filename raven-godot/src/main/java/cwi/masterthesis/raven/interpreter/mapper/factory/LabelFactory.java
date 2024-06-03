package cwi.masterthesis.raven.interpreter.mapper.factory;

import cwi.masterthesis.raven.interpreter.nodes.control.RavenLabel;
import cwi.masterthesis.raven.interpreter.nodes.RavenNode;
import godot.Node;

import java.util.Map;

public class LabelFactory implements RavenNodeFactory {
    @Override
    public RavenNode createRavenNode(Node mainRavenNode, Map<String, String> attrMap) {
        return new RavenLabel(
                attrMap.get("id"),
                mainRavenNode,
                attrMap.get("text"),
                attrMap.get("styles") == null ? null : attrMap.get("styles"),
                Integer.parseInt(attrMap.get("xPosition")),
                Integer.parseInt(attrMap.get("yPosition")));
    }
}