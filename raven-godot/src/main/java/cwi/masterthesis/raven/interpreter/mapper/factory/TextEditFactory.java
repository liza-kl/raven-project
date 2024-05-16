package cwi.masterthesis.raven.interpreter.mapper.factory;

import cwi.masterthesis.raven.interpreter.nodes.RavenNode;
import cwi.masterthesis.raven.interpreter.nodes.control.RavenTextEdit;
import godot.Node;

import java.util.Map;

public class TextEditFactory implements RavenNodeFactory{
    @Override
    public RavenNode createRavenNode(Node node, Map<String, String> attrMap) {
        return new RavenTextEdit(attrMap.get("id"),
                                node,
                                attrMap.get("text"),
                                attrMap.get("callback"));
    }

}
