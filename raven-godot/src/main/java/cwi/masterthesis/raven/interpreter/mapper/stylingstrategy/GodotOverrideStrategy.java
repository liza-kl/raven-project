package cwi.masterthesis.raven.interpreter.mapper.stylingstrategy;

import godot.Control;
import godot.core.StringNameUtils;
import java.lang.reflect.Constructor;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class GodotOverrideStrategy implements StylingStrategy {

    private final Control node;
    private final String property;
    private final String value;

    public GodotOverrideStrategy(Control node, String property, String value) {
        this.node = node;
        this.property = property;
        this.value = value;
    }

    @Override
    public void applyStyling() {
        Object parsedValue = parseValue(this.value);
        node.set(StringNameUtils.asStringName(this.property), parsedValue);
    }

    private Object parseValue(String value) {
        Pattern pattern = Pattern.compile("(\\w+)\\(([^)]+)\\)");
        Matcher matcher = pattern.matcher(value);

        if (matcher.matches()) {
            String className = matcher.group(1);
            String params = matcher.group(2);
            String[] paramArray = params.split(",");

            try {
                String fullClassName = "godot.core." + className;
                Class<?> clazz = Class.forName(fullClassName);
                return createInstance(clazz, paramArray);
            } catch (Exception e) {
                throw new RuntimeException("Failed to parse value: " + value, e);
            }
        }

        return value; // Default to returning the string if no pattern is matched
    }

    private Object createInstance(Class<?> clazz, String[] paramArray) throws Exception {
        Class<?>[] paramTypes = new Class<?>[paramArray.length];
        Object[] params = new Object[paramArray.length];

        for (int i = 0; i < paramArray.length; i++) {
            String param = paramArray[i].trim();
            Object parsedParam = parseParam(param);
            paramTypes[i] = parsedParam.getClass();
            params[i] = parsedParam;
        }

        Constructor<?> constructor = clazz.getConstructor(paramTypes);
        return constructor.newInstance(params);
    }

    private Object parseParam(String param) {
        if (param.matches("-?\\d+\\.\\d+")) {
            return Float.parseFloat(param);
        } else if (param.matches("-?\\d+")) {
            return Integer.parseInt(param);
        } else if (param.equalsIgnoreCase("true") || param.equalsIgnoreCase("false")) {
            return Boolean.parseBoolean(param);
        } else {
            return param; // Default to string if no other type matches
        }
    }
}
