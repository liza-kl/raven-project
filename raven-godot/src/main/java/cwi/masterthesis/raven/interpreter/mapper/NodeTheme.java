package cwi.masterthesis.raven.interpreter.mapper;

import java.util.List;
import java.util.Map;

public class NodeTheme {
    private Map<String, List<PropertySettings>> themes;


    public Map<String, List<PropertySettings>> getThemes() {
        return themes;
    }

    public void setThemes(Map<String, List<PropertySettings>> themes) {
        this.themes = themes;
    }
}
