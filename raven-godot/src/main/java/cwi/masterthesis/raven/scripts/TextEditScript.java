package cwi.masterthesis.raven.scripts;

import cwi.masterthesis.raven.application.client.NativeClient;
import cwi.masterthesis.raven.interpreter.nodes.control.RavenTextEdit;
import godot.annotation.RegisterClass;
import godot.annotation.RegisterFunction;
import godot.annotation.RegisterSignal;
import godot.core.Callable;
import godot.core.StringNameUtils;
import godot.signals.Signal;
import godot.signals.SignalProvider;

@RegisterClass
public class TextEditScript extends RavenTextEdit {
    @RegisterSignal
    public Signal textSendMessage = SignalProvider.signal(this, "text_send_message");
    @RegisterSignal
    public Signal textInit = SignalProvider.signal(this, "text_init");

    @RegisterFunction
    public void callbackTextEdit() {
        NativeClient.getInstance(
                "0.0.0.0",
                23000,
                getTree().getRoot().getChild(0)).send((String) this.get(StringNameUtils.asStringName("node_callback")));
    }
    @RegisterFunction
    public void callbackTextInit(String callback) {
        this.set(StringNameUtils.asStringName("node_callback"),callback);
        this.notifyPropertyListChanged();
    }


    @RegisterFunction
    public void _ready() {
        System.out.println("TextEdit is connected to script");
        connect(
                StringNameUtils.asStringName("text_send_message"),
                new Callable(this, StringNameUtils.asStringName("callback_text_edit"))
        );
        connect(
                StringNameUtils.asStringName("text_init"),
                new Callable(this, StringNameUtils.asStringName("callback_text_init"))
        );
    }
}
