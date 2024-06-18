package cwi.masterthesis.raven.interpreter.mapper.factory;

import cwi.masterthesis.raven.interpreter.nodes.RavenNode;
import cwi.masterthesis.raven.interpreter.nodes.control.RavenMarginContainer;
import godot.Node;

import java.util.Map;

public class MarginContainerFactory implements RavenNodeFactory{
    @Override
    public RavenNode createRavenNode(Node node, Map attrMap) {
        return new RavenMarginContainer(
                (String) attrMap.get("id"),
                node,
                (String) attrMap.get("name"),
                (attrMap.get("styles") == null ? null : (String) attrMap.get("styles"))
        );
    }


}
