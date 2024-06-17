package cwi.masterthesis.raven.interpreter.mapper.stylingstrategy;

import godot.Control;
import godot.StyleBoxFlat;
import godot.core.Color;
import godot.core.StringNameUtils;

import java.lang.reflect.InvocationTargetException;
import java.util.Map;
import java.util.Objects;

import static cwi.masterthesis.raven.interpreter.mapper.stylingstrategy.ColorStrategy.getColorByName;
import static cwi.masterthesis.raven.interpreter.mapper.stylingstrategy.PrimitiveOverrideStrategy.detectConverter;

public class StyleBoxFlatOverrideStrategy implements StylingStrategy{
    private final Control node; // something like Button
    // TODO maybe create an enum for that
    private final String state; // Can be something like "normal" or "hovered" or "disabled".
    private final Map<String, Object> values;//  background color, whatever.

    public StyleBoxFlatOverrideStrategy(Control node, String state, Map<String, Object> values) {
        this.node = node;
        this.state = state;
        this.values = values;
    }

    private Object parseValue(String entryKey, String value) {
        if (value.contains("%")) { // For Primitive Value stuff
            return detectConverter((String) value);
        }
        if (entryKey.contains("color")) {
            return new Color(Objects.requireNonNull(getColorByName((String) value)));
        }
        return value;
    }
    private StyleBoxFlat createStyleBox(Control node, String stateToOverwrite) throws InvocationTargetException, IllegalAccessException {

        StyleBoxFlat current = (StyleBoxFlat) node.getThemeStylebox(StringNameUtils.asStringName(stateToOverwrite)).duplicate();

        for (var entry : values.entrySet()) {
            assert current != null;
            try {
            current.set(StringNameUtils.asStringName(entry.getKey()),
                            parseValue(entry.getKey(), (String) entry.getValue()));}
            catch (Exception e) {
                System.err.println("Could not set value for key " + entry.getKey());
            }
        }
        assert current != null;
        return current;

        // you can add all those things here
        // https://docs.godotengine.org/en/stable/classes/class_styleboxflat.html
    }


    @Override
    public void applyStyling() {
        try {
            StyleBoxFlat box = this.createStyleBox(this.node, this.state);
            this.node.addThemeStyleboxOverride(StringNameUtils.asStringName(this.state),box);
        } catch (InvocationTargetException | IllegalAccessException e) {
            throw new RuntimeException(e);
        }
    }
}
