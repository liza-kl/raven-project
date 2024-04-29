package cwi.masterthesis.raven.interpreter.mapper;

import cwi.masterthesis.raven.interpreter.nodes.RavenNode;
import godot.Node;

import java.util.Map;

public interface RavenNodeFactory {
    RavenNode createRavenNode(Node mainRavenNode, Map<String, String> attrMap);
}


