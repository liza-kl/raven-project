package cwi.masterthesis.raven.interpreter;

import java.lang.reflect.Method;

public final class InterpreterUtils {

    public static void invokeMethod(String methodName, Object... arguments) {
        try {
            // Get the Class object for the Visitor class
            Class<?> visitorClass = Visitor.class;
            // Prepare an array to hold the types of the arguments
            Class<?>[] argumentTypes = new Class[arguments.length];
            for (int i = 0; i < arguments.length; i++) {
                argumentTypes[i] = arguments[i].getClass();
            }

            // Get the method with the specified name from the Visitor class
            Method method = visitorClass.getMethod("visit" + methodName, argumentTypes);

            // Create an instance of the Visitor class
            Interpreter visitor = Interpreter.getInstance();

            // Invoke the method on the Visitor instance
            method.invoke(visitor, arguments);
            // Using this to activate the garbage collector.
            visitor = null;
        } catch (Exception e) {
            // Handle any exceptions
            e.printStackTrace();
        }
    }

    public static String toCamelCase(String snakeCase, boolean inverted) {
        StringBuilder result = new StringBuilder();
        boolean capitalizeNext = inverted;

        for (char c : snakeCase.toCharArray()) {
            if (c == '_') {
                capitalizeNext = true;
            } else {
                if (capitalizeNext) {
                    result.append(Character.toUpperCase(c));
                    capitalizeNext = false;
                } else {
                    result.append(c);
                }
            }
        }

        return result.toString();
    }
}