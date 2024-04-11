package cwi.masterthesis.raven;

import godot.Node;
import godot.Node2D;
import godot.annotation.RegisterClass;
import godot.annotation.RegisterFunction;
import godot.global.GD;


@RegisterClass
public class StartUp extends Node2D {
    @RegisterFunction
    @Override
    public void _ready() {
        System.out.println("Started Application");
        FileUtils.createAProtocolFile();
    }

}
