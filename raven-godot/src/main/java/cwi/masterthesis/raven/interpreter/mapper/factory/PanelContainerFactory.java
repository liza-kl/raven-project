package cwi.masterthesis.raven.interpreter.mapper.factory;

import cwi.masterthesis.raven.interpreter.nodes.RavenNode;
import cwi.masterthesis.raven.interpreter.nodes.control.RavenPanelContainer;
import godot.Node;

import java.util.Map;

public class PanelContainerFactory implements RavenNodeFactory {
    @Override
    public RavenNode createRavenNode(Node node, Map<String, String> attrMap) {
        return new RavenPanelContainer(
                attrMap.get("id"),
                node,
                attrMap.get("name"),
                attrMap.get("styles") == null ? null : attrMap.get("styles")
        );
    }
}
