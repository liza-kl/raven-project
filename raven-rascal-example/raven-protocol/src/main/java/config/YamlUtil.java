package config;

import java.io.IOException;
import java.io.InputStream;
import org.yaml.snakeyaml.Yaml;

import java.util.List;
import java.util.Map;

public class YamlUtil {
    private Map<String, Object> yamlConfig;

    public YamlUtil(String fileName) {
        Yaml yaml = new Yaml();
        try (InputStream in = getClass().getClassLoader().getResourceAsStream(fileName)) {
            if (in == null) {
                throw new IllegalArgumentException("File not found: " + fileName);
            }
            yamlConfig = yaml.load(in);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @SuppressWarnings("unchecked")
    public List<String> getRascalSearchPath() {
        return (List<String>) ((Map<String, Object>) yamlConfig.get("app")).get("rascal-search-path");
    }

    @SuppressWarnings("unchecked")
    public List<String> getImports() {
        return (List<String>) ((Map<String, Object>) yamlConfig.get("app")).get("imports");
    }

    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> getMainConfig() {
        return (List<Map<String, Object>>) ((Map<String, Object>) yamlConfig.get("app")).get("main");
    }


    public Object getConfig(String key) {
        return yamlConfig.get(key);
    }
}
