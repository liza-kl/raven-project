package cwi.masterthesis.raven.scripts;

import cwi.masterthesis.raven.application.client.NativeClient;
import godot.Button;
import godot.Node;
import godot.annotation.*;
import godot.core.Callable;
import godot.core.StringNameUtils;
import godot.signals.Signal;
import godot.signals.SignalProvider;

@RegisterClass

public class ButtonSendMessage extends Button {

    @RegisterSignal
    public Signal buttonSendMessage = SignalProvider.signal(this, "button_send_message");

    @RegisterSignal
    public Signal buttonInit = SignalProvider.signal(this, "button_init");

    @Export
    @RegisterProperty
    public String nodeCallback = "";

    @RegisterFunction
    public void _ready() {
        System.out.println("the button is ready");
        connect(
                StringNameUtils.asStringName("button_init"),
                new Callable(this, StringNameUtils.asStringName("callback_button_init"))
        );
        connect(
                StringNameUtils.asStringName("button_send_message"),
                new Callable(this, StringNameUtils.asStringName("callback_send_message"))
        );

    }

    @RegisterFunction
    public void callbackButtonInit(String callback) {
        System.out.println("button_init emitted");
        this.set(StringNameUtils.asStringName("node_callback"),callback);
        this.notifyPropertyListChanged();
    }


    @RegisterFunction
    public void callbackSendMessage(Node node) {
        NativeClient.getInstance("0.0.0.0",23000,
                        getTree().getRoot().getChild(0))
                    .send("CALLBACK:" + (String) this.get(StringNameUtils.asStringName("node_callback")));
    }

    @RegisterFunction
    public void _pressed() {
        System.out.println("Sending Content");
        emitSignal(StringNameUtils.asStringName("button_send_message"), this);
    }
}

