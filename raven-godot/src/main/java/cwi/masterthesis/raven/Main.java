package cwi.masterthesis.raven;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;
import cwi.masterthesis.raven.application.client.ClientFactory;
import cwi.masterthesis.raven.application.client.NativeClient;
import cwi.masterthesis.raven.application.client.StandardClientFactory;
import cwi.masterthesis.raven.interpreter.mapper.RavenJSONTraverser;
import cwi.masterthesis.raven.interpreter.mapper.stylingstrategy.ColorStrategy;
import cwi.masterthesis.raven.interpreter.mapper.stylingstrategy.FontSizeStrategy;
import cwi.masterthesis.raven.interpreter.mapper.stylingstrategy.StyleBoxFlatStrategy;
import cwi.masterthesis.raven.interpreter.mapper.stylingstrategy.StylingStrategy;
import godot.Node;
import godot.Theme;
import godot.annotation.RegisterClass;
import godot.annotation.RegisterFunction;
import godot.annotation.RegisterSignal;
import godot.core.Callable;
import godot.core.StringNameUtils;
import godot.global.GD;
import godot.signals.Signal;
import godot.signals.SignalProvider;

import java.lang.reflect.InvocationTargetException;
import java.util.Iterator;
import java.util.Map;

@RegisterClass
public class Main extends Node {
    public Node mainNode;
    public static Theme mainTheme;
    private static StylingStrategy strategy;

    @RegisterSignal
    public Signal mainUpdateScene = SignalProvider.signal(this, "main_update_scene");


    @RegisterSignal
    public Signal mainInitGeneralTheme = SignalProvider.signal(this, "main_init_general_theme");

    @RegisterFunction
    public void callbackInitGeneralTheme(String theme) throws JsonProcessingException {

        GD.INSTANCE.print("Initializing the theme");

        try {
            styleTraverser(theme);
        } catch (InvocationTargetException | NoSuchMethodException | IllegalAccessException e) {
            throw new RuntimeException(e);
        }
        this.getTree().getRoot().setTheme(mainTheme);
    }


    @RegisterFunction
    public void callbackUpdateScene(String jsonSpec) {
        var nodes = this.mainNode.getChild(0).getChildren();
        for (var node : nodes) {
            this.mainNode.getChild(0).removeChild(node);
            node.queueFree();
        }
     traverseJSON(jsonSpec, this.mainNode.getChild(0));
    }



        ClientFactory clientFactory = new StandardClientFactory();
  //  Client client = clientFactory.createClientFromType("native");
    NativeClient client;
    @RegisterFunction
    @Override
    public void _process(double delta) {
   //    client.virtualProcess();
    }


    // The goal is that everytime we get a new json into the buffer to parse it.
    @RegisterFunction
    @Override
    public void _ready() {
        this.mainNode = getTree().getRoot();
        mainTheme = new Theme();
        connect(
                StringNameUtils.asStringName("main_update_scene"),
                new Callable(this, StringNameUtils.asStringName("callback_update_scene"))
        );
        connect(
                StringNameUtils.asStringName("main_init_general_theme"),
                new Callable(this, StringNameUtils.asStringName("callback_init_general_theme"))
        );
        connect(
                StringNameUtils.asStringName("main_print_signal"),
                new Callable(this, StringNameUtils.asStringName("callback_print"))
        );
//        String sceneTreePath = "/Users/ekletsko/raven-project/raven-core/src/main/rascal/styles.json";
//        String exampleRequest = null;
//        try {
//            exampleRequest = Files.readString(Path.of(sceneTreePath), StandardCharsets.UTF_8);
//        } catch (IOException e) {
//            throw new RuntimeException(e);
//        }
//        try {
//            styleTraverser(exampleRequest);
//        } catch (JsonProcessingException | IllegalAccessException | NoSuchMethodException | InvocationTargetException e) {
//            throw new RuntimeException(e);
//        }

        this.client = NativeClient.getInstance("0.0.0.0", 23000, this.mainNode);
        GD.INSTANCE.print("main Node in Main Class" + this.mainNode);
        client.virtualReady();
//        String sceneTreePath = "/Users/ekletsko/raven-project/raven-core/src/main/rascal/tree.json";
//        String exampleRequest = FileAccess.Companion.getFileAsString(sceneTreePath);
//        GD.INSTANCE.print(exampleRequest);
//        traverseJSON(exampleRequest,  this.mainNode.getChild(0));

    }
    @RegisterFunction
    public static void styleTraverser(String theme) throws JsonProcessingException, InvocationTargetException, NoSuchMethodException, IllegalAccessException {
        ObjectMapper mapper = new ObjectMapper();
        JsonNode elements = mapper.readTree(theme);
        for (JsonNode elem : elements) {
            String key = elem.fieldNames().next();

            ArrayNode valueNode = (ArrayNode) elem.get(key);

            for (JsonNode value : valueNode) {
                String themeprop = value.fieldNames().next();
                JsonNode valueContent = value.get(themeprop);

                // Assuming valueContent is an ObjectNode with key-value pairs
                Iterator<Map.Entry<String, JsonNode>> fields = valueContent.fields();
                while (fields.hasNext()) {
                    Map.Entry<String, JsonNode> entry = fields.next();

                    if (themeprop.equals("Color")) {
                        strategy = new ColorStrategy(key, entry.getKey(),entry.getValue().asText());
                    }
                    if (themeprop.equals("FontSize")) {
                        strategy = new FontSizeStrategy(key, entry.getKey(),entry.getValue().asInt());
                    }
                    if (themeprop.equals("StyleboxFlat")) {
                        Map<String, Object> result = mapper.convertValue(entry.getValue(), new TypeReference<>() {
                        });
                        strategy = new StyleBoxFlatStrategy(key, entry.getKey(), result);
                    }
                    strategy.applyStyling();

                }
            }
        }
    }

    public static void setDefaultValues() {

    }


    @RegisterFunction
    public static void traverseJSON(String sceneTreeJSON, Node mainNode) {
        GD.INSTANCE.print("Traverse JSON is called");
        ObjectMapper mapper = new ObjectMapper();
        JsonNode rootNode;
        try {
            rootNode = mapper.readTree(sceneTreeJSON);
        } catch (JsonProcessingException e) {
            throw new RuntimeException(e);
        }

        try {
            RavenJSONTraverser.traverse(rootNode, mainNode);
        } catch (JsonProcessingException e) {
            throw new RuntimeException(e);
        }
    }
}
