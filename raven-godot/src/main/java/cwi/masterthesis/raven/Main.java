package cwi.masterthesis.raven;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import cwi.masterthesis.raven.application.client.ClientFactory;
import cwi.masterthesis.raven.application.client.NativeClient;
import cwi.masterthesis.raven.application.client.StandardClientFactory;
import cwi.masterthesis.raven.files.FileUtils;
import cwi.masterthesis.raven.interpreter.mapper.RavenJSONTraverser;
import godot.FileAccess;
import godot.Node;
import godot.annotation.RegisterClass;
import godot.annotation.RegisterFunction;
import godot.core.NodePath;

@RegisterClass
public class Main extends Node {
    public Node mainNode = getNode(new NodePath("."));
    ClientFactory clientFactory = new StandardClientFactory();
  //  Client client = clientFactory.createClientFromType("native");
    NativeClient client = NativeClient.getInstance("0.0.0.0", 23000);
    @RegisterFunction
    @Override
    public void _process(double delta) {
       client.virtualProcess();
    }

    @RegisterFunction
    @Override
    public void _ready() {
        client.virtualReady();
        String sceneTreePath = "/Users/ekletsko/raven-project/raven-core/src/main/rascal/tree.json";
        FileUtils.createAProtocolFile();
        getRavenJSONTraverser(sceneTreePath);
    }

    private void getRavenJSONTraverser(String sceneTreePath) {
        String exampleRequest = FileAccess.Companion.getFileAsString(sceneTreePath);

        RavenJSONTraverser traverser = new RavenJSONTraverser();

        ObjectMapper mapper = new ObjectMapper();
        JsonNode rootNode;
        try {
            rootNode = mapper.readTree(exampleRequest);
        } catch (JsonProcessingException e) {
            throw new RuntimeException(e);
        }

        try {
            traverser.traverse(rootNode, this.mainNode);
        } catch (JsonProcessingException e) {
            throw new RuntimeException(e);
        }
    }

}
