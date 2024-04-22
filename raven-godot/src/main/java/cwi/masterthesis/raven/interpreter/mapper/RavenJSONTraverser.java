package cwi.masterthesis.raven.interpreter.mapper;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.node.ArrayNode;
import cwi.masterthesis.raven.interpreter.nodes.RavenButton;
import cwi.masterthesis.raven.interpreter.nodes.RavenLabel;
import cwi.masterthesis.raven.interpreter.nodes.RavenNode;
import godot.JSON;
import godot.Node;

import java.util.*;

// Gluebit is the ugly part
// interpreter can be built for other game engines
// Design is more general
public class RavenJSONTraverser extends Node {
    private String sceneTreeSpec;
    private Node godotRootNode;
    private java.lang.Object convertedSceneTreeSpec;
    private Map<String, Class<?>> stringClassMap = new HashMap<>();
    private String CLASS_PREFIX = "Raven";
    List<RavenNode> sceneToBuild;

    public List<RavenNode> getSceneToBuild() {
        return sceneToBuild;
    }

    public RavenJSONTraverser(String sceneTreeSpec, Node godotRootNode) {
        this.sceneTreeSpec = sceneTreeSpec;
        this.convertedSceneTreeSpec = JSON.Companion.parseString(sceneTreeSpec);
        this.sceneToBuild =  new ArrayList<>();
        this.godotRootNode = godotRootNode;
    }

//    public void traverse(java.lang.Object tree) {
//        Visitor interpreter = new Interpreter();
//
//        if(convertedSceneTreeSpec != null && convertedSceneTreeSpec instanceof VariantArray) {
//
//        }
//
//        if(convertedSceneTreeSpec != null && convertedSceneTreeSpec instanceof Dictionary) {
//            Dictionary<?, ?> sceneGraphDict = (Dictionary<?, ?>) this.convertedSceneTreeSpec;
//            String nodeID = (String) sceneGraphDict.get("id");
//
//            VariantArray children = (VariantArray) sceneGraphDict.get("children");
//
//
//            if (children != null) {
//                for (int i = 0; i < children.size(); i++) {
//                    Field[] fields = children.getClass().getDeclaredFields();
//                    for (Object child : children) {
//                        traverse(child);
//                    }
//                }
//            }
//        }
//
//
//    }

    public static List<String> getKeysInJsonUsingJsonNodeFieldNames(JsonNode jsonNode) throws JsonMappingException, JsonProcessingException {

        List<String> keys = new ArrayList<>();
        Iterator<String> iterator = jsonNode.fieldNames();
        iterator.forEachRemaining(e -> keys.add(e));
        return keys;
    }

    public static List<String> getNodeAttributes(JsonNode jsonNode, List<String> keys) {

        if (jsonNode.isObject()) {
            Iterator<Map.Entry<String, JsonNode>> fields = jsonNode.fields();
            fields.forEachRemaining(field -> {
                keys.add(field.getKey());
                getNodeAttributes((JsonNode) field.getValue(), keys);
            });
        } else if (jsonNode.isArray()) {
            ArrayNode arrayField = (ArrayNode) jsonNode;
            arrayField.forEach(node -> {
                getNodeAttributes(node, keys);
            });
        }
        return keys;
    }

    public void traverse(JsonNode node, int childrenSize) throws JsonProcessingException {
        int amountOfChildren = 0;
        List<String> keysList = new ArrayList<>();

        List<String> keys = RavenJSONTraverser.getNodeAttributes(node, keysList);
        if (node.isArray()) {
            amountOfChildren = node.size();
            for (int i = 0; i < amountOfChildren; i++) {
                String nodeType = node.get(i).fieldNames().next();
                switch (nodeType) {
                    case "Label":
                        // Handle label node
                        ArrayList<String> list = new ArrayList<>();
                        var attr = node.get(0).get(nodeType).fieldNames();
                        while (attr.hasNext()) {
                            list.add(attr.next());
                        }
                        System.out.println(list.toString());
                        // get_node() is always relative to what it's called from.
                        var label = new RavenLabel(godotRootNode, "My counter application", 10,5);
                        sceneToBuild.add(label);
                        break;
                    case "Button":
                        // Handle button node
                        System.out.println("Found button node:");
                        var incButton = new RavenButton(godotRootNode, "+", 10, 2, "inc()");
                        System.out.println(nodeType);
                        sceneToBuild.add(incButton);
                        break;
                    default:
                        System.out.println("Unknown node type: " + nodeType);
                        break;

                }
            }
        }

        if (node.isObject()) {
            String nodeType = null;
            JsonNode childNode = node.get("children");
            if (!(childNode.isEmpty())) {
                // Handle children node recursively
                System.out.println("Found children node:");
                traverse(childNode, childNode.size() - 1);
            }
        }


    }
}
