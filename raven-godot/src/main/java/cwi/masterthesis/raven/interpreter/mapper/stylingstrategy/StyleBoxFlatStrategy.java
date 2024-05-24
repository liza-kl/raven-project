package cwi.masterthesis.raven.interpreter.mapper.stylingstrategy;

import godot.StyleBox;
import godot.StyleBoxFlat;
import godot.core.Color;
import godot.core.StringNameUtils;

import java.util.Map;
import java.util.Objects;

import static cwi.masterthesis.raven.Main.mainTheme;
import static cwi.masterthesis.raven.interpreter.mapper.stylingstrategy.ColorStrategy.getColorByName;

/**
 * StyleboxFlat is used to style Buttons
 * See: https://docs.godotengine.org/en/stable/classes/class_styleboxflat.html
 */
public class StyleBoxFlatStrategy implements StylingStrategy{


    private final String nodeName; // something like Button
    // TODO maybe create an enum for that
    private final String state; // Can be something like "normal" or "hovered" or "disabled".
    private final Map<String, Object> values;//  background color, whatever.

    public StyleBoxFlatStrategy(String nodeName, String state, Map<String, Object> values) {
        this.nodeName = nodeName;
        this.state = state;
        this.values = values;
    }


    private Object parseValue(String entryKey, Object value) {
        if (entryKey.contains("color")) {
            return new Color(Objects.requireNonNull(getColorByName((String) value)));
        }
        throw new IllegalArgumentException("No suitable converter found.");
    }
    private StyleBox createStyleBox() {
        StyleBox styleBox = new StyleBoxFlat();
        for (var entry : values.entrySet()) {
            styleBox.set(StringNameUtils.asStringName(entry.getKey()),
                    parseValue(entry.getKey(), entry.getValue()));
        }

        // you can add all those things here
        // https://docs.godotengine.org/en/stable/classes/class_styleboxflat.html
      return styleBox;
    }


    @Override
    public void applyStyling() {
        mainTheme.setStylebox(StringNameUtils.asStringName(this.state),
                StringNameUtils.asStringName(this.nodeName), this.createStyleBox());
    }
}
