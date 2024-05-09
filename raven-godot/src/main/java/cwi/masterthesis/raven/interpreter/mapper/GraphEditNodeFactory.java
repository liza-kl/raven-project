package cwi.masterthesis.raven.interpreter.mapper;

import cwi.masterthesis.raven.interpreter.nodes.RavenGraphEditNode;
import cwi.masterthesis.raven.interpreter.nodes.RavenNode;
import godot.Node;

import java.util.Map;

public class GraphEditNodeFactory implements RavenNodeFactory {
    @Override
    public RavenNode createRavenNode(Node mainRavenNode, Map<String, String> attrMap) {
        return new RavenGraphEditNode( attrMap.get("id"), mainRavenNode);
    }
}
