package cwi.masterthesis.raven.scripts;

import cwi.masterthesis.raven.interpreter.nodes.control.RavenButton;
import godot.annotation.RegisterClass;
import godot.annotation.RegisterFunction;

@RegisterClass

public class ButtonDebug extends RavenButton {

    @RegisterFunction
    public void _pressed() {
        System.out.println("Debug Button");
    }
}

