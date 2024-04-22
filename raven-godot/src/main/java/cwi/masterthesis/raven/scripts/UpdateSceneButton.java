package cwi.masterthesis.raven.scripts;

import cwi.masterthesis.raven.files.FileUtils;
import godot.Button;
import godot.annotation.RegisterClass;
import godot.annotation.RegisterFunction;
import godot.global.GD;

@RegisterClass

public class UpdateSceneButton extends Button {

        @RegisterFunction
        public void _ready() {
            System.out.println("the button is ready");
        }
        @RegisterFunction
        public void _pressed() {
            System.out.println("Writing to file");
            GD.INSTANCE.print("Writing to file");
            FileUtils.deleteFileContent();
            FileUtils.writeToFile("Create new UI " + System.currentTimeMillis());
            System.out.println("Written to file");
        }
    }

