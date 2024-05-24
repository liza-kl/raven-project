package client;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;
import org.eclipse.core.internal.filesystem.FileSystemAccess;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.Map;

public class Random {


    public static void styleTraverser(String theme) throws JsonProcessingException {
        ObjectMapper mapper = new ObjectMapper();
        JsonNode elements = mapper.readTree(theme);
        for (JsonNode elem : elements) {
            String key = elem.fieldNames().next();
            ArrayNode valueNode = (ArrayNode) elem.get(key);

            for (JsonNode value : valueNode) {
                String themeprop = value.fieldNames().next();
                JsonNode valueContent = value.get(themeprop);

                // Assuming valueContent is an ObjectNode with key-value pairs
                Iterator<Map.Entry<String, JsonNode>> fields = valueContent.fields();
                while (fields.hasNext()) {
                    Map.Entry<String, JsonNode> entry = fields.next();


                    System.out.println("The theming option is " + key + themeprop + entry.getKey() + ":" + entry.getValue().toString());
                }
            }
        }
    }

    public static void main(String[] args) throws IOException {
        String sceneTreePath = "/Users/ekletsko/raven-project/raven-core/src/main/rascal/styles.json";
        String exampleRequest = Files.readString(Path.of(sceneTreePath), StandardCharsets.UTF_8);
        styleTraverser(exampleRequest);
    }

}
