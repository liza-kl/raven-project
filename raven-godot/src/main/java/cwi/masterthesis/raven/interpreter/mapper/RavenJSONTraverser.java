package cwi.masterthesis.raven.interpreter.mapper;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import cwi.masterthesis.raven.interpreter.InterpreterUtils;
import cwi.masterthesis.raven.interpreter.mapper.factory.RavenNodeFactory;
import cwi.masterthesis.raven.interpreter.nodes.RavenNode;
import godot.Node;
import godot.core.NodePath;
import org.jetbrains.annotations.NotNull;

import java.util.HashMap;

public final class RavenJSONTraverser {

    /**
     * @param node – The current node being examined from the JSON, e.g. a "Label"
     * @param mainNode – This node should be replaced with a general parent node in the future, because otherwise it
     * limits the building graph by attaching everything to only one main node.
     * @throws JsonProcessingException
     */
    public static void traverse(JsonNode node, Node mainNode) throws JsonProcessingException {
        if (node.isArray()) {
            int amountOfChildren = node.size();
            for (int i = 0; i < amountOfChildren; i++) {
                String nodeType = node.get(i).fieldNames().next();
                HashMap<String, String> attrMap = getAttrMap(node, nodeType, i);
                RavenNodeFactory factory = RavenNodeFactoryProvider.getFactory(nodeType);
                RavenNode childNode = factory.createRavenNode(mainNode, attrMap);
                InterpreterUtils.invokeMethod(nodeType, childNode);
                var pathToCheck = attrMap.get("name") != null ? attrMap.get("name") :  attrMap.get("id");
                Node childNodePath = mainNode.getNode(new NodePath(pathToCheck)) ; // Update current path
                JsonNode childChildrenNode = node.get(i).findValue("children");
                if (childChildrenNode != null && !childChildrenNode.isEmpty()) {
                    traverse(childChildrenNode, childNodePath); // Pass the updated path
                }

            }
        }
        if (node.isObject()) {
            JsonNode childNode = node.findValue("children");
            if (!(childNode.isEmpty())) {
                traverse(childNode, mainNode);
            }
        }
    }

    /**
     * Populate each node with the set attributes from the Raven Side
     */
    private static @NotNull HashMap<String, String> getAttrMap(JsonNode node, String nodeType, int index) {
        var attr = node.get(index).get(nodeType).fieldNames();
        HashMap<String, String> attrMap = new HashMap<>();

        while (attr.hasNext()) {
            String key = attr.next();
            // TODO define map for values which need a pretty string
            String value =  ((key == "styles") || (key == "options")) ? node.get(index).get(nodeType).get(key).toPrettyString(): node.get(index).get(nodeType).get(key).asText();

            attrMap.put(key, value);
        }
        return attrMap;
    }


}
