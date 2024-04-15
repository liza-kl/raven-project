package cwi.masterthesis.raven;

import cwi.masterthesis.raven.files.FileUtils;
import godot.Camera2D;
import godot.annotation.RegisterClass;
import godot.annotation.RegisterFunction;


@RegisterClass
public class Main extends Camera2D {
    @RegisterFunction
    @Override
    public void _ready() {
        System.out.println("Started Application");
        FileUtils.createAProtocolFile();
    }

}
