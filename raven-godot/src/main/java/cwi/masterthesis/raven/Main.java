package cwi.masterthesis.raven;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import cwi.masterthesis.raven.interpreter.Interpreter;
import cwi.masterthesis.raven.interpreter.mapper.RavenJSONTraverser;
import cwi.masterthesis.raven.interpreter.nodes.RavenLabel;
import godot.FileAccess;
import godot.Node;
import godot.annotation.RegisterClass;
import godot.annotation.RegisterFunction;
import godot.core.NodePath;

@RegisterClass
public class Main extends Node {

    @RegisterFunction
    @Override
    public void _ready() {
        System.out.println("Started Application");
        String sceneTreePath = "/Users/ekletsko/raven-project/raven-core/src/main/rascal/tree.json";


//        var decButton = new RavenButton(getNode(new NodePath(".")), "-", 15, 2, "dec()");

        Node godotRootNode = getNode(new NodePath("."));
        var label = new RavenLabel(godotRootNode, "My Counter Application", 10, 5);
        var interpreter = new Interpreter();
       // interpreter.visitButton(incButton);
        //interpreter.visitButton(decButton);
       // interpreter.visitLabel(label);
        String exampleRequest = FileAccess.Companion.getFileAsString(sceneTreePath);

        RavenJSONTraverser traverser = new RavenJSONTraverser(exampleRequest, godotRootNode);

        ObjectMapper mapper = new ObjectMapper();
        JsonNode rootNode;
        try {
            rootNode = mapper.readTree(exampleRequest);
        } catch (JsonProcessingException e) {
            throw new RuntimeException(e);
        }

        try {
            traverser.traverse(rootNode,0);
        } catch (JsonProcessingException e) {
            throw new RuntimeException(e);
        }

        var elements = traverser.getSceneToBuild();
        for (var element : elements) {
           element.acceptVisitor(interpreter);
        }
        //FileUtils.createAProtocolFile();
    }



}
