package cwi.masterthesis.raven.interpreter.mapper;

import java.util.HashMap;
import java.util.Map;
import java.util.function.Supplier;

public class RavenNodeFactoryProvider {
    private static final Map<String, Supplier<RavenNodeFactory>> factoryMap = new HashMap<>();

    static {
        factoryMap.put("Label", LabelFactory::new);
        factoryMap.put("Button", ButtonFactory::new);
    }

    public static RavenNodeFactory getFactory(String nodeType) {
        Supplier<RavenNodeFactory> factorySupplier = factoryMap.get(nodeType);
        if (factorySupplier == null) {
            throw new IllegalArgumentException("Unknown node type: " + nodeType);
        }
        return factorySupplier.get();
    }
}
