package cwi.masterthesis.raven.interpreter.mapper.stylingstrategy;

import godot.Control;

public class AnchorPresetOverrideStrategy implements StylingStrategy {
    private final Control node;
    private final String property;
    private final String value;

    public AnchorPresetOverrideStrategy(Control node, String property, String value) {
        this.node = node;
        this.property = property;
        this.value = value;
    }



    @Override
    public void applyStyling() {

        node.setAnchorsPreset(Control.LayoutPreset.valueOf(this.value));
    }
}
