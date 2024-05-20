package cwi.masterthesis.raven.interpreter.mapper.factory;

import cwi.masterthesis.raven.interpreter.nodes.RavenNode;
import cwi.masterthesis.raven.interpreter.nodes.control.RavenTabContainer;
import godot.Node;

import java.util.Map;

public class TabContainerFactory implements RavenNodeFactory{
    @Override
    public RavenNode createRavenNode(Node node, Map<String, String> attrMap) {
        return new RavenTabContainer(
                node,
                attrMap.get("id")
        );
    }
}
