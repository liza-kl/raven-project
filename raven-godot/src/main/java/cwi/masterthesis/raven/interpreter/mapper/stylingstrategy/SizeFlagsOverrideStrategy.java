package cwi.masterthesis.raven.interpreter.mapper.stylingstrategy;

import godot.Control;

import java.lang.reflect.Method;
import java.util.Objects;

public class SizeFlagsOverrideStrategy implements StylingStrategy {
    private final Control node;
    private final String property;
    private final String value;

    public SizeFlagsOverrideStrategy(Control node, String property, String value) {
        this.node = node;
        this.property = property;
        this.value = value;
    }

    public static Control.SizeFlags getSizeFlagsByString(String sizeFlag) {
        try {
            Class<?> companionClass = Control.SizeFlags.Companion.class;
            Method method = companionClass.getMethod("get" + sizeFlag);

            return (Control.SizeFlags) method.invoke(Control.SizeFlags.Companion);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public void applyStyling() {
        if(this.property.contains("size_flags_horizontal")) {
            this.node.setSizeFlagsHorizontal(Objects.requireNonNull(getSizeFlagsByString(this.value)));
        }
        if(this.property.contains("size_flags_vertical")) {
            this.node.setSizeFlagsVertical(Objects.requireNonNull(getSizeFlagsByString(this.value)));

        }
    }
}
