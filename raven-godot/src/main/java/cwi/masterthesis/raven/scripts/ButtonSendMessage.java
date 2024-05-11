package cwi.masterthesis.raven.scripts;

import com.fasterxml.jackson.databind.ObjectMapper;
import cwi.masterthesis.raven.application.client.NativeClient;
import godot.Button;
import godot.Node;
import godot.annotation.RegisterClass;
import godot.annotation.RegisterFunction;
import godot.annotation.RegisterSignal;
import godot.core.Callable;
import godot.core.StringNameUtils;
import godot.signals.Signal;
import godot.signals.SignalProvider;

import java.io.File;
import java.io.IOException;

@RegisterClass

public class ButtonSendMessage extends Button {

    @RegisterSignal
    public Signal buttonSendMessage = SignalProvider.signal(this, "button_send_message");

    @RegisterFunction
    public void _ready() {
        System.out.println("the button is ready");
        connect(
                StringNameUtils.asStringName("button_send_message"),
                new Callable(this, StringNameUtils.asStringName("callback_send_message"))
        );

    }

    public String createMessage(String topic, String jsonContent, String initiator) {
        return String.format("Topic: %s \n" +
                                "JSON: %s  \n" +
                                "Initiator: %s  \n", topic, jsonContent, initiator);
    }

    @RegisterFunction
    public void callbackSendMessage(Node button) {
        String sceneTreePath = "/Users/ekletsko/raven-project/raven-core/src/main/rascal/tree.json";
        ObjectMapper objectMapper = new ObjectMapper();
        String jsonString = null;

        try {
            File jsonFile = null;
            Object jsonData = null;
            // Read JSON from file into a JSON tree
            jsonFile = new File(sceneTreePath);
            jsonData = objectMapper.readValue(jsonFile, Object.class);

            // Convert JSON tree to string
            jsonString = objectMapper.writeValueAsString(jsonData);
        } catch (IOException e) {
            e.printStackTrace();
        }


        NativeClient.getInstance("0.0.0.0",23000,getTree().getRoot().getChild(0)).send("Current Message");
    }

    @RegisterFunction
    public void _pressed() {
        System.out.println("Sending Content");
        emitSignal(StringNameUtils.asStringName("button_send_message"), this);
    }
}

