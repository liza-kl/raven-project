package cwi.masterthesis.raven.interpreter.mapper.factory;

import cwi.masterthesis.raven.interpreter.nodes.RavenNode;
import cwi.masterthesis.raven.interpreter.nodes.control.RavenHBoxContainer;
import godot.Node;

import java.util.Map;

public class HBoxContainerFactory implements RavenNodeFactory{
    @Override
    public RavenNode createRavenNode(Node node, Map<String, String> attrMap) {
        return new RavenHBoxContainer(
                attrMap.get("id"),
                node,
                attrMap.get("name")
        );
    }
}
