package cwi.masterthesis.raven.scripts;

import cwi.masterthesis.raven.files.FileUtils;
import cwi.masterthesis.raven.interpreter.nodes.RavenButton;
import godot.annotation.RegisterClass;
import godot.annotation.RegisterFunction;

@RegisterClass

public class UpdateSceneButton extends RavenButton {

    @RegisterFunction
        public void _ready() {
            System.out.println("the button is ready");
        }

        @RegisterFunction
        public void _pressed() {
            System.out.println("Press");
            FileUtils.deleteFileContent();
            FileUtils.writeToFile("Create new UI " + System.currentTimeMillis());
            System.out.println("Written to file");

        }
}

