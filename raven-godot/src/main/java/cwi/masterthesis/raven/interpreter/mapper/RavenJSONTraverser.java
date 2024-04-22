package cwi.masterthesis.raven.interpreter.mapper;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import cwi.masterthesis.raven.interpreter.nodes.RavenNode;
import godot.Node;
import org.jetbrains.annotations.NotNull;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

// Gluebit is the ugly part
// interpreter can be built for other game engines
// Design is more general
public class RavenJSONTraverser extends Node {

    List<RavenNode> sceneToBuild;

    public List<RavenNode> getSceneToBuild() {
        return sceneToBuild;
    }

    public RavenJSONTraverser() {
        this.sceneToBuild =  new ArrayList<>();
    }

    public void traverse(JsonNode node, Node mainNode) throws JsonProcessingException {
        if (node.isArray()) {
            int amountOfChildren = node.size();
            for (int i = 0; i < amountOfChildren; i++) {
                String nodeType = node.get(i).fieldNames().next();
                HashMap<String, String> attrMap = getAttrMap(node, nodeType, i);
                RavenNodeFactory factory = RavenNodeFactoryProvider.getFactory(nodeType);
                sceneToBuild.add(factory.createRavenNode(mainNode, attrMap));
            }
        }

        if (node.isObject()) {
            JsonNode childNode = node.get("children");
            if (!(childNode.isEmpty())) {
                traverse(childNode,mainNode);
            }
        }


    }

    private static @NotNull HashMap<String, String> getAttrMap(JsonNode node, String nodeType, int index) {
        var attr = node.get(index).get(nodeType).fieldNames();
        HashMap<String, String> attrMap = new HashMap<>();

        while (attr.hasNext()) {
            String key = attr.next(); // Retrieve the current key
            String value = node.get(index).get(nodeType).get(key).asText(); // Retrieve the corresponding value
            attrMap.put(key, value); // Put the key-value pair into the map
        }
        return attrMap;
    }
}
