package cwi.masterthesis.raven.interpreter.mapper;

import cwi.masterthesis.raven.interpreter.mapper.factory.*;
import org.reflections.Reflections;

import java.util.HashMap;
import java.util.Map;
import java.util.Set;
import java.util.function.Supplier;

public class RavenNodeFactoryProvider {
    private static final Map<String, Supplier<RavenNodeFactory>> factoryMap = new HashMap<>();


    static {
        initFactoryMap();
    }


    /* Prior to this function each class was separately put into the static init block.
    e.g.  factoryMap.put("Label", LabelFactory::new);
        factoryMap.put("Button", ButtonFactory::new);
        factoryMap.put("Node2D", Node2DFactory::new)
        ...
   Now we read in all factories from the package and generate the code once, when the class is loaded into memory tp
     prevent unnecessary overhead.*/
    private static void initFactoryMap() {
        Reflections reflections = new Reflections("cwi.masterthesis.raven.interpreter.mapper.factory");

        Set<Class<? extends RavenNodeFactory>> allClasses =
                reflections.getSubTypesOf(RavenNodeFactory.class);

        allClasses.forEach(classElem -> {
            if(!classElem.isInterface() && !java.lang.reflect.Modifier.isAbstract(classElem.getModifiers())) {
                String className = classElem.getSimpleName();
                String nodeType = className.replace("Factory", "");
                factoryMap.put(nodeType, () -> {
                    try {
                        return (RavenNodeFactory) classElem.getDeclaredConstructor().newInstance();
                    } catch (Exception e) {
                        throw new RuntimeException("Failed to instantiate factory: " + classElem.getName(), e);
                    }
                });

            }
        });
    }

    public static RavenNodeFactory getFactory(String nodeType) {
        Supplier<RavenNodeFactory> factorySupplier = factoryMap.get(nodeType);
        if (factorySupplier == null) {
            throw new IllegalArgumentException("Unknown node type: " + nodeType);
        }
        return factorySupplier.get();
    }
}
