package cwi.masterthesis.raven.interpreter.mapper.stylingstrategy;

import com.fasterxml.jackson.databind.JsonNode;
import godot.Node;
import godot.core.StringNameUtils;

public class PrimitiveOverrideStrategy implements StylingStrategy{
    private final Node node;
    private final String property;
    private final JsonNode value;

    public PrimitiveOverrideStrategy(Node node, String property, JsonNode value) {
        this.node = node;
        this.property = property;
        this.value = value;
    }

    @Override
    public void applyStyling() {
        // FIXME write generic converter to infer value
        node.set(StringNameUtils.asStringName(this.property), this.value);
    }
}
