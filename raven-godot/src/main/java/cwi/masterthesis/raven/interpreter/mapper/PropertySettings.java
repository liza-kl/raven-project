package cwi.masterthesis.raven.interpreter.mapper;

import java.util.HashMap;
import java.util.Map;

public class PropertySettings {
    private  String name;
    private  Map<String, ?> values = new HashMap<>();


    public String getName() {
        return name;
    }
    public Map<String, ?> getValues() {
        return values;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setValues(Map<String, ?> values) {
        this.values = values;
    }
}
