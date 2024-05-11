package cwi.masterthesis.raven.interpreter.mapper;

import cwi.masterthesis.raven.interpreter.mapper.factory.*;

import java.util.HashMap;
import java.util.Map;
import java.util.function.Supplier;

public class RavenNodeFactoryProvider {
    private static final Map<String, Supplier<RavenNodeFactory>> factoryMap = new HashMap<>();

    static {
        factoryMap.put("Label", LabelFactory::new);
        factoryMap.put("Button", ButtonFactory::new);
        factoryMap.put("Node2D", Node2DFactory::new);
        factoryMap.put("GraphNode", GraphNodeFactory::new);
        factoryMap.put("GraphEditNode", GraphEditNodeFactory::new);
        factoryMap.put("Control", ControlFactory::new);
    }

    public static RavenNodeFactory getFactory(String nodeType) {
        Supplier<RavenNodeFactory> factorySupplier = factoryMap.get(nodeType);
        if (factorySupplier == null) {
            throw new IllegalArgumentException("Unknown node type: " + nodeType);
        }
        return factorySupplier.get();
    }
}
