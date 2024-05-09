package cwi.masterthesis.raven.interpreter.mapper;

import cwi.masterthesis.raven.interpreter.nodes.RavenNode;
import cwi.masterthesis.raven.interpreter.nodes.RavenNode2D;
import godot.Node;

import java.util.Map;

public class Node2DFactory implements RavenNodeFactory{
    @Override
    public RavenNode createRavenNode(Node mainRavenNode, Map<String, String> attrMap) {
        return new RavenNode2D(
                mainRavenNode,
                attrMap.get("id"));

    }
}
