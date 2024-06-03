package cwi.masterthesis.raven.interpreter.mapper.factory;

import cwi.masterthesis.raven.interpreter.nodes.RavenNode;
import cwi.masterthesis.raven.interpreter.nodes.control.RavenHBoxContainer;
import godot.Node;

import java.util.Map;

public class HBoxContainerFactory implements RavenNodeFactory{
    @Override
    public RavenNode createRavenNode(Node node, Map attrMap) {
        return new RavenHBoxContainer(
                (String) attrMap.get("id"),
                node,
                (String) attrMap.get("name"),
                (String) attrMap.get("styles")
        );
    }


}
