package cwi.masterthesis.raven.scripts;

import cwi.masterthesis.raven.application.client.GodotClient;
import godot.Button;
import godot.annotation.RegisterClass;
import godot.annotation.RegisterFunction;

@RegisterClass

public class ButtonSendMessage extends Button {

    @RegisterFunction
    public void _ready() {
        System.out.println("the button is ready");
    }

    @RegisterFunction
    public void _pressed() {
        System.out.println("Sending Content");
//        System.out.println("Status" + Client.getInstance().getStatus());
//        byte[] input = "ping".getBytes();
//        PackedByteArray packed = new PackedByteArray();
//        for (int i = 0; i < input.length; i++) {
//            packed.append(input[i]);
//        }
//        Client.getInstance().send(packed);
   //     NativeClient.getInstance("0.0.0.0", 23000).send("ping");
        GodotClient.getInstance().send("ping");
    }
}

