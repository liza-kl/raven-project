package cwi.masterthesis.raven.interpreter.nodes;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import cwi.masterthesis.raven.interpreter.mapper.stylingstrategy.*;
import godot.Control;
import godot.Node;

import java.util.Map;

public class StylingStrategyOverride {
    private final ObjectMapper mapper = new ObjectMapper();

    public StylingStrategy getStrategy(String themeProp, Node node, Map.Entry<String, JsonNode> entry) {
        ThemeProperty property = ThemeProperty.valueOf(themeProp.toUpperCase());
        return property.createStrategy(node, entry, mapper);
    }

    private enum ThemeProperty {
        VECTOR2 {
            @Override
            StylingStrategy createStrategy(Node node, Map.Entry<String, JsonNode> entry, ObjectMapper mapper) {
                Map<String, String> result = mapper.convertValue(entry.getValue(), new TypeReference<>() {});
                return new Vector2OverrideStrategy((Control) node, entry.getKey(), Integer.valueOf(result.get("x")), Integer.valueOf(result.get("y")));
            }
        },
        PRIMITIVE {
            @Override
            StylingStrategy createStrategy(Node node, Map.Entry<String, JsonNode> entry, ObjectMapper mapper) {
                return new PrimitiveOverrideStrategy(node, entry.getKey(), entry.getValue().asText());
            }
        },
        COLOR {
            @Override
            StylingStrategy createStrategy(Node node, Map.Entry<String, JsonNode> entry, ObjectMapper mapper) {
                return new ColorOverrideStrategy((Control) node, entry.getKey(), entry.getValue().asText());
            }
        },
        FONTSIZE {
            @Override
            StylingStrategy createStrategy(Node node, Map.Entry<String, JsonNode> entry, ObjectMapper mapper) {
                return new FontSizeOverrideStrategy((Control) node, entry.getKey(), entry.getValue().asInt());
            }
        },
        SIZEFLAGS {
            @Override
            StylingStrategy createStrategy(Node node, Map.Entry<String, JsonNode> entry, ObjectMapper mapper) {
                return new SizeFlagsOverrideStrategy((Control) node, entry.getKey(), entry.getValue().asText());
            }
        },
        ANCHORPRESET {
            @Override
            StylingStrategy createStrategy(Node node, Map.Entry<String, JsonNode> entry, ObjectMapper mapper) {
                return new AnchorPresetOverrideStrategy((Control) node, entry.getKey(), entry.getValue().asText());
            }
        },
        STYLEBOXFLAT {
            @Override
            StylingStrategy createStrategy(Node node, Map.Entry<String, JsonNode> entry, ObjectMapper mapper) {
                Map<String, Object> result = mapper.convertValue(entry.getValue(), new TypeReference<>() {});
                return new StyleBoxFlatOverrideStrategy((Control) node, entry.getKey(), result);
            }
        };

        abstract StylingStrategy createStrategy(Node node, Map.Entry<String, JsonNode> entry, ObjectMapper mapper);
    }
}
