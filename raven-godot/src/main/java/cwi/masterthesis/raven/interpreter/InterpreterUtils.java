package cwi.masterthesis.raven.interpreter;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public final class InterpreterUtils {
    public static Map<String, Object> getFieldValues(Object object) {
        Map<String, Object> fieldValues = new HashMap<>();
        Class<?> cls = object.getClass();

        Field[] fields = cls.getDeclaredFields();
        for (Field field : fields) {
            field.setAccessible(true);
            Object value = null;
            try {
                value = field.get(object);
            } catch (IllegalAccessException e) {
                throw new RuntimeException(e);
            }
            fieldValues.put(field.getName(), value);
        }

        return fieldValues;
    }

    public static ArrayList<String> getFieldsOfClass(Object cls) throws ClassNotFoundException {
        Field[] fieldList = cls.getClass().getDeclaredFields();
        ArrayList<String> fieldNames = new ArrayList<>();
        for (Field aFieldlist : fieldList) {
            fieldNames.add(aFieldlist.getName());
        }
        return fieldNames;
    }

    public static List<Method> getSettersOfClass(Object cls) throws ClassNotFoundException {
        List<Method> setters = new ArrayList<>();
        Method[] methods = cls.getClass().getDeclaredMethods();
        for (Method method : methods) {
            if (method.getName().startsWith("set")) {
                setters.add(method);
            }
        }
        return setters;
    }


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
            Interpreter visitor = new Interpreter();

            // Invoke the method on the Visitor instance
            method.invoke(visitor, arguments);
        } catch (Exception e) {
            // Handle any exceptions
            e.printStackTrace();
        }
    }
}