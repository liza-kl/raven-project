package cwi.masterthesis.raven.scripts;

import cwi.masterthesis.raven.application.Client;
import godot.Button;
import godot.annotation.RegisterClass;
import godot.annotation.RegisterFunction;
import godot.core.PackedByteArray;

@RegisterClass

public class ButtonSendMessage extends Button {

    @RegisterFunction
    public void _ready() {
        System.out.println("the button is ready");
    }

    @RegisterFunction
    public void _pressed() {
        System.out.println("Sending Content");
        System.out.println("Status" + Client.getInstance().getStatus());
        byte[] input = "ping".getBytes();
        PackedByteArray packed = new PackedByteArray();
        for (int i = 0; i < input.length; i++) {
            packed.append(input[i]);
        }
        Client.getInstance().send(packed);


    }
}

