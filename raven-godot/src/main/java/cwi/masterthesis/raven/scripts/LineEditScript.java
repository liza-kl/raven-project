package cwi.masterthesis.raven.scripts;

import cwi.masterthesis.raven.application.client.NativeClient;
import cwi.masterthesis.raven.interpreter.nodes.control.RavenLineEdit;
import godot.annotation.RegisterClass;
import godot.annotation.RegisterFunction;
import godot.annotation.RegisterSignal;
import godot.core.Callable;
import godot.core.StringNameUtils;
import godot.signals.Signal;
import godot.signals.SignalProvider;

import java.util.concurrent.Executors;
import java.util.concurrent.Future;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

@RegisterClass
public class LineEditScript extends RavenLineEdit {
    @RegisterSignal
    public Signal textSendMessage = SignalProvider.signal(this, "text_send_message");
    @RegisterSignal
    public Signal lineInit = SignalProvider.signal(this, "line_init");

    private final ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(1);
    private Future<?> lastScheduledFuture = null;
    private final int debounceDelay = 500; // debounce delay in milliseconds

    @RegisterFunction
    public void callbackTextChanged() {
        /*
         * The scheduling here allows for a JavaScript like debounce effect. Because we are not diffing (yet),
         * this is the only way to ensure that a callback doesn't get fired on every char change.
         * */
        if (lastScheduledFuture != null && !lastScheduledFuture.isDone()) {
            lastScheduledFuture.cancel(false);
        }

        lastScheduledFuture = scheduler.schedule(() -> {
            String content = "\"" + this.getText() + "\"";
            String callback = (String) this.get(StringNameUtils.asStringName("node_callback"));
            assert callback != null;
            // TODO Assuming callback has only one % parameter for now
            // Rascal is accepting strings and then converting to custom types.
            String alteredCallback = callback.replaceAll("%(\\w+)", content);
            this.callbackLineEdit(alteredCallback);
        }, debounceDelay, TimeUnit.MILLISECONDS);
    }

    @RegisterFunction
    public void callbackLineEdit(String callback) {
        NativeClient.getInstance(
                        "0.0.0.0",
                        23000,
                        getTree().getRoot().getChild(0))
                .send("CALLBACK: " + callback);
    }

    @RegisterFunction
    public void callbackLineInit(String callback) {
        this.set(StringNameUtils.asStringName("node_callback"), callback);
        this.notifyPropertyListChanged();
    }

    @RegisterFunction
    public void _ready() {
        System.out.println("TextEdit is connected to script");
        connect(
                StringNameUtils.asStringName("text_changed"),
                new Callable(this, StringNameUtils.asStringName("callback_text_changed"))
        );
        connect(
                StringNameUtils.asStringName("line_init"),
                new Callable(this, StringNameUtils.asStringName("callback_line_init"))
        );
    }
}
