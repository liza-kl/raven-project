package cwi.masterthesis.raven.interpreter.mapper.factory;

import cwi.masterthesis.raven.interpreter.nodes.RavenNode;
import cwi.masterthesis.raven.interpreter.nodes.control.RavenPanel;
import godot.Node;

import java.util.Map;

public class PanelFactory implements RavenNodeFactory {
    @Override
    public RavenNode createRavenNode(Node node, Map<String, String> attrMap) {
        return new RavenPanel(
                attrMap.get("id"),
                node,
                attrMap.get("name"),
                attrMap.get("styles") == null ? null : attrMap.get("styles")
        );
    }
}