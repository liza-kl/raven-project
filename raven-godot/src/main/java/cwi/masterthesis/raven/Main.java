package cwi.masterthesis.raven;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import cwi.masterthesis.raven.application.Client;
import cwi.masterthesis.raven.files.FileUtils;
import cwi.masterthesis.raven.interpreter.Interpreter;
import cwi.masterthesis.raven.interpreter.mapper.RavenJSONTraverser;
import cwi.masterthesis.raven.interpreter.nodes.RavenNode;
import godot.FileAccess;
import godot.Node;
import godot.StreamPeerTCP;
import godot.annotation.RegisterClass;
import godot.annotation.RegisterFunction;
import godot.core.NodePath;
import godot.core.PackedByteArray;
import godot.core.StringNameUtils;
import godot.core.VariantArray;
import org.jetbrains.annotations.NotNull;

import java.util.List;

@RegisterClass
public class Main extends Node {
    public Node mainNode = getNode(new NodePath("."));
    Client client = new Client();

    @RegisterFunction
    @Override
    public void _process(double delta) {
        var status = this.client.getStatus();
        var newStatus = this.client.getStreamPeerTCP().getStatus();
        if (newStatus != status) {
            this.client.setStatus(newStatus);
            switch(newStatus) {
                case STATUS_NONE: {
                    System.out.println("Disconnected from host");
                    client.emitSignal(StringNameUtils.asStringName("stream_disconnected"));
                    break;
                }
                case STATUS_CONNECTING: {
                    System.out.println("Connecting to host");
                    break;
                }
                case STATUS_CONNECTED: {
                    System.out.println("Connected to host");
                    client.emitSignal(StringNameUtils.asStringName("stream_connected"));
                    break;
                }
                case STATUS_ERROR: {
                    System.out.println("Error with Socket Stream");
                    client.emitSignal(StringNameUtils.asStringName("stream_error"));
                    break;
                }
            }
        }
        if (status == StreamPeerTCP.Status.STATUS_CONNECTED) {
            var availableBytes = client.getStreamPeerTCP().getAvailableBytes();
            if (availableBytes > 0) {
                System.out.println("Available bytes: " + availableBytes);
                VariantArray data  = client.getStreamPeerTCP().getPartialData(availableBytes);
                try {
                    data.get(0);
                } catch (Exception e) {
                    System.out.println("Error reading data from Stream: " + e.getMessage());
                    client.emitSignal(StringNameUtils.asStringName("stream_error"));
                }
                client.emitSignal(StringNameUtils.asStringName("stream_data"), data.get(1));
            }
        }
    }

    @RegisterFunction
    @Override
    public void _ready() {
        client.connectClientSignals();
        client.setStatus(client.getStatus());
        client.connectToHost();

        byte[] input = "ping".getBytes();
        PackedByteArray packed = new PackedByteArray();
        for (int i = 0; i < input.length; i++) {
            packed.append(input[i]);
        }

        if (client.getStatus() == StreamPeerTCP.Status.STATUS_CONNECTED) {
            client.send(packed);
        }
        String sceneTreePath = "/Users/ekletsko/raven-project/raven-core/src/main/rascal/tree.json";
        FileUtils.createAProtocolFile();
        var interpreter = new Interpreter();
        RavenJSONTraverser traverser = getRavenJSONTraverser(sceneTreePath);
        List<RavenNode> elements = traverser.getSceneToBuild();
        for (var element : elements) {
           element.acceptVisitor(interpreter);
        }

        FileUtils.writeToFile(String.valueOf(getTree().getRoot()));
    }

    private @NotNull RavenJSONTraverser getRavenJSONTraverser(String sceneTreePath) {
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
        return traverser;
    }

}
