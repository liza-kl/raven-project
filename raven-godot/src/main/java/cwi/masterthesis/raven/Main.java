package cwi.masterthesis.raven;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import cwi.masterthesis.raven.files.FileUtils;
import cwi.masterthesis.raven.interpreter.Interpreter;
import cwi.masterthesis.raven.interpreter.mapper.RavenJSONTraverser;
import cwi.masterthesis.raven.interpreter.nodes.RavenNode;
import godot.FileAccess;
import godot.Node;
import godot.annotation.RegisterClass;
import godot.annotation.RegisterFunction;
import godot.core.NodePath;
import org.jetbrains.annotations.NotNull;

import java.util.List;

@RegisterClass
public class Main extends Node {
    public Node mainNode = getNode(new NodePath("."));


    @RegisterFunction
    @Override
    public void _ready() {
        System.out.println("Started Application");
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
