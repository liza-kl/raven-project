package cwi.masterthesis.raven.interpreter.mapper.stylingstrategy;

import godot.Node;
import godot.core.StringNameUtils;

import java.util.Objects;

public class PrimitiveOverrideStrategy implements StylingStrategy{
    private final Node node;
    private final String property;
    private final Object value;

    public static Object detectConverter(String value) {

        String[] splitted = value.split("%");
        String type = splitted[0];
        String strValue = splitted[1];

        if(Objects.equals(type, "Boolean")) return Boolean.parseBoolean( strValue );
        if(Objects.equals(type, "Byte")) return Byte.parseByte( strValue );
        if(Objects.equals(type, "Short")) return Short.parseShort( strValue );
        if(Objects.equals(type, "Int") ) return Integer.parseInt( strValue );
        if(Objects.equals(type, "Long") ) return Long.parseLong( strValue );
        if(Objects.equals(type, "Float") ) return Float.parseFloat( strValue );
        if(Objects.equals(type, "Double")) return Double.parseDouble( strValue );
        return strValue;
    }

    public PrimitiveOverrideStrategy(Node node, String property, String value) {
        this.node = node;
        this.property = property;
        this.value = detectConverter(value);
    }

    @Override
    public void applyStyling() {
        // FIXME write generic converter to infer value
        node.set(StringNameUtils.asStringName(this.property), this.value);
    }
}
