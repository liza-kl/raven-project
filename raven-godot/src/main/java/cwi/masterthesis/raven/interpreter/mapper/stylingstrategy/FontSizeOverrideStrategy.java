package cwi.masterthesis.raven.interpreter.mapper.stylingstrategy;

import godot.Control;
import godot.core.StringNameUtils;

public class FontSizeOverrideStrategy implements StylingStrategy{
    private final Control node;
    private final String themingKey;
    private final int value;


    public FontSizeOverrideStrategy(Control node, String themingKey, int value) {
        this.node = node;
        this.themingKey = themingKey;
        this.value = value;
    }

    @Override
    public void applyStyling() {
        node.addThemeFontSizeOverride(StringNameUtils.asStringName(this.themingKey), this.value);
    }
}
