package cwi.masterthesis.raven.interpreter.mapper.stylingstrategy;

import godot.Node;
import godot.core.StringNameUtils;

public class PrimitiveOverrideStrategy implements StylingStrategy{
    private final Node node;
    private final String property;
    private final Object value;

    public static Object detectConverter(String value) {

        String[] splitted = value.split("%");
        String type = splitted[0];
        String strValue = splitted[1];

        PrimitiveTypeConverter converter = new PrimitiveTypeConverter();
        try {
            return converter.getConverter(type, strValue);
        } catch (Exception e) {
            System.err.println("Could not convert " + type + " to " + strValue);
            e.printStackTrace();
            return strValue;
        }
    }

    public PrimitiveOverrideStrategy(Node node, String property, String value) {
        this.node = node;
        this.property = property;
        this.value = detectConverter(value);
    }

    @Override
    public void applyStyling() {

        if (this.property == "current_tab") {
            node.callDeferred(StringNameUtils.asStringName("set"),
                    StringNameUtils.asStringName(this.property), this.value );
        } else {
            node.set(StringNameUtils.asStringName(this.property), this.value);
        }

    }
}
