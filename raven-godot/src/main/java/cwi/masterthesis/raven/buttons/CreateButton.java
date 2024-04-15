package cwi.masterthesis.raven.buttons;

import godot.Button;
import godot.Node;
import godot.annotation.RegisterClass;
import godot.annotation.RegisterFunction;
import godot.core.Vector2;
import godot.global.GD;

@RegisterClass
public class CreateButton extends Button {

    public void createButton(String callback, String label, int XCoordinate, int YCoordinate) {
        Node parent = getParent();
        var button = new Button();
        button.setText(label);
        button.setSceneFilePath("res://scenes/CustomButton");
        button.setScript("gdj/cwi/masterthesis/raven/buttons/UpdateSceneButton.gdj");
        button.setPosition(new Vector2(XCoordinate, YCoordinate));
        parent.addChild(button);

    }

    @RegisterFunction
    public void _pressed(String printmessage) {
        GD.INSTANCE.print(printmessage);
        createButton("inc()", "TestButton", 0, 5);
    }
}
