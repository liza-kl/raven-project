package cwi.masterthesis.raven;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import cwi.masterthesis.raven.application.client.ClientFactory;
import cwi.masterthesis.raven.application.client.NativeClient;
import cwi.masterthesis.raven.application.client.StandardClientFactory;
import cwi.masterthesis.raven.interpreter.mapper.RavenJSONTraverser;
import godot.FileAccess;
import godot.Node;
import godot.annotation.RegisterClass;
import godot.annotation.RegisterFunction;
import godot.annotation.RegisterSignal;
import godot.core.Callable;
import godot.core.StringNameUtils;
import godot.global.GD;
import godot.signals.Signal;
import godot.signals.SignalProvider;

@RegisterClass
public class Main extends Node {
    public Node mainNode;

    @RegisterSignal
    public Signal mainUpdateScene = SignalProvider.signal(this, "main_update_scene");

    @RegisterFunction
    public void callbackUpdateScene(String jsonSpec) {
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
        this.client = NativeClient.getInstance("0.0.0.0", 23000, this.mainNode);
        GD.INSTANCE.print("main Node in Main Class" + this.mainNode);
        client.virtualReady();
        String sceneTreePath = "/Users/ekletsko/raven-project/raven-core/src/main/rascal/tree.json";
        String exampleRequest = FileAccess.Companion.getFileAsString(sceneTreePath);
        traverseJSON(exampleRequest,  this.mainNode.getChild(0));

        connect(
                StringNameUtils.asStringName("main_update_scene"),
                new Callable(this, StringNameUtils.asStringName("callback_update_scene"))
        );
    }

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
