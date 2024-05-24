package cwi.masterthesis.raven.interpreter.mapper.stylingstrategy;

import godot.core.StringNameUtils;

import static cwi.masterthesis.raven.Main.mainTheme;

public class FontSizeStrategy implements StylingStrategy {
    private final String nameOfNode;
    private final String themingKey;
    private final int value;

    public FontSizeStrategy(String nameOfNode, String themingKey, int value) {
        this.nameOfNode = nameOfNode;
        this.themingKey = themingKey;
        this.value = value;
    }

    @Override
    public void applyStyling() {
            mainTheme.setFontSize(StringNameUtils.asStringName(this.themingKey),
                    StringNameUtils.asStringName(this.nameOfNode), this.value);
        }
}
