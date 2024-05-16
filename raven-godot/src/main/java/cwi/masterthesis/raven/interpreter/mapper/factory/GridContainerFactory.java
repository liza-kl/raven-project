package cwi.masterthesis.raven.interpreter.mapper.factory;

import cwi.masterthesis.raven.interpreter.nodes.RavenNode;
import cwi.masterthesis.raven.interpreter.nodes.control.RavenGridContainer;
import godot.Node;

import java.util.Map;

// FIXME: Look for alternative
public class GridContainerFactory implements RavenNodeFactory {
    @Override
    public RavenNode createRavenNode(Node node, Map<String, String> attrMap) {
        return new RavenGridContainer(
                attrMap.get("id"),
                node,
                1,
                1,
                1,
                1,
                1
        );
    }
}
