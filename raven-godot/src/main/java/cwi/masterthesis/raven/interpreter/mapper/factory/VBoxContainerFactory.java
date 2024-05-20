package cwi.masterthesis.raven.interpreter.mapper.factory;

import cwi.masterthesis.raven.interpreter.nodes.RavenNode;
import cwi.masterthesis.raven.interpreter.nodes.control.RavenVBoxContainer;
import godot.Node;

import java.util.Map;

public class VBoxContainerFactory implements RavenNodeFactory {
    @Override
    public RavenNode createRavenNode(Node node, Map<String, String> attrMap) {
        return new RavenVBoxContainer(
                attrMap.get("id"),
                node
        );
    }
}
