package cwi.masterthesis.raven.interpreter.mapper.factory;

import cwi.masterthesis.raven.interpreter.nodes.control.RavenGraphNode;
import cwi.masterthesis.raven.interpreter.nodes.RavenNode;
import godot.Node;

import java.util.Map;

public class GraphNodeFactory implements RavenNodeFactory
{
    @Override
    public RavenNode createRavenNode(Node mainRavenNode, Map<String, String> attrMap) {
        return new RavenGraphNode(mainRavenNode, attrMap.get("id"));
    }
}
