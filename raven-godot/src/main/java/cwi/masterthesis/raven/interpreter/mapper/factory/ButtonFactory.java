package cwi.masterthesis.raven.interpreter.mapper.factory;

import cwi.masterthesis.raven.interpreter.nodes.control.RavenButton;
import cwi.masterthesis.raven.interpreter.nodes.RavenNode;
import godot.Node;

import java.util.Map;

public class ButtonFactory implements RavenNodeFactory {
    @Override
    public  RavenNode createRavenNode(Node mainRavenNode, Map<String, String> attrMap) {
        return new RavenButton(
                attrMap.get("id"),
                mainRavenNode,
                attrMap.get("text"),
                attrMap.get("callback"),
                attrMap.get("styles") == null ? null : attrMap.get("styles"));
    }


}
