package cwi.masterthesis.raven.interpreter.mapper.factory;

import cwi.masterthesis.raven.interpreter.nodes.RavenNode;
import godot.Node;

import java.util.Map;

public interface RavenNodeFactory {
    RavenNode createRavenNode(Node node, Map<String, String> attrMap);
}



