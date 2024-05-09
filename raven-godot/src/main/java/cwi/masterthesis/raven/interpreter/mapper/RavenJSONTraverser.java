package cwi.masterthesis.raven.interpreter.mapper;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import cwi.masterthesis.raven.interpreter.InterpreterUtils;
import cwi.masterthesis.raven.interpreter.nodes.RavenNode;
import godot.Node;
import godot.core.NodePath;
import org.jetbrains.annotations.NotNull;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public final class RavenJSONTraverser extends Node {

    /**
     *
     */
    private final List<RavenNode> sceneToBuild;

    public List<RavenNode> getSceneToBuild() {
        return sceneToBuild;
    }

    public RavenJSONTraverser() {
        this.sceneToBuild =  new ArrayList<>();
    }



    /**
     * @param node – The current node being examined from the JSON, e.g. a "Label"
     * @param mainNode – This node should be replaced with a general parent node in the future, because otherwise it
     * limits the building graph by attaching everything to only one main node.
     * @throws JsonProcessingException
     */
    public void traverse(JsonNode node, Node mainNode) throws JsonProcessingException {
        if (node.isArray()) {
            int amountOfChildren = node.size();
            for (int i = 0; i < amountOfChildren; i++) {
                String nodeType = node.get(i).fieldNames().next();
                HashMap<String, String> attrMap = getAttrMap(node, nodeType, i);
                RavenNodeFactory factory = RavenNodeFactoryProvider.getFactory(nodeType);
                RavenNode childNode = factory.createRavenNode(mainNode, attrMap);
                InterpreterUtils.invokeMethod(nodeType, childNode);
                Node childNodePath = mainNode.getNode(new NodePath(attrMap.get("id"))); // Update current path
                JsonNode childChildrenNode = node.get(i).findValue("children");
                if (childChildrenNode != null && !childChildrenNode.isEmpty()) {
                    traverse(childChildrenNode, childNodePath); // Pass the updated path
                }

            }
        }
        if (node.isObject()) {
            JsonNode childNode = node.findValue("children");
            if (!(childNode.isEmpty())) {
                traverse(childNode, mainNode); // Pass the updated path
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
