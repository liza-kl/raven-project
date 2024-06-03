package cwi.masterthesis.raven.interpreter.mapper.stylingstrategy;

import godot.Control;
import godot.core.Color;
import godot.core.StringNameUtils;

public class ColorOverrideStrategy implements StylingStrategy{

    private final Control node;
    private final String themingKey;
    private final Color color;

    public ColorOverrideStrategy(Control node, String themingKey, Color color) {
        this.node = node;
        this.themingKey = themingKey;
        this.color = color;
    }

    @Override
    public void applyStyling() {
        node.addThemeColorOverride(StringNameUtils.asStringName(this.themingKey), this.color);
    }
}
