package cwi.masterthesis.raven;

import godot.Button;
import godot.Node;
import godot.annotation.RegisterClass;
import godot.annotation.RegisterFunction;

@RegisterClass

public class UpdateSceneButton extends Button {
        @RegisterFunction
        public void _pressed() {
            System.out.println("Writing to file");
            FileUtils.deleteFileContent();
            FileUtils.writeToFile("Create new UI " + System.currentTimeMillis());
            System.out.println("Written to file");
            Button button = new Button();
            Node parent = this.getParent();
            parent.addChild(button);
        }
    }

