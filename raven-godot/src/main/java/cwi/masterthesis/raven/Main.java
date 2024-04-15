package cwi.masterthesis.raven;

import cwi.masterthesis.raven.files.FileUtils;
import godot.Node;
import godot.annotation.RegisterClass;
import godot.annotation.RegisterFunction;


@RegisterClass
public class Main extends Node {
    @RegisterFunction
    @Override
    public void _ready() {
        System.out.println("Started Application");
        FileUtils.createAProtocolFile();
    }

}
