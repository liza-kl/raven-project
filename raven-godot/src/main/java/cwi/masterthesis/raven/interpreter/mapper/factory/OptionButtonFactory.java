package cwi.masterthesis.raven.interpreter.mapper.factory;

import cwi.masterthesis.raven.interpreter.nodes.RavenNode;
import cwi.masterthesis.raven.interpreter.nodes.control.RavenOptionButton;
import godot.Node;

import java.util.Map;

public class OptionButtonFactory implements RavenNodeFactory{

    @Override
    public RavenNode createRavenNode(Node node, Map<String, String> attrMap) {
        return new RavenOptionButton(
                node,
                attrMap.get("id"),
                attrMap.get("options"));

    }


}
