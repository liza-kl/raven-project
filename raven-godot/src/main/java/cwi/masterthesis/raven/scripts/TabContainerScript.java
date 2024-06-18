package cwi.masterthesis.raven.scripts;

import cwi.masterthesis.raven.application.client.NativeClient;
import cwi.masterthesis.raven.interpreter.nodes.control.RavenOptionButton;
import godot.annotation.RegisterClass;
import godot.annotation.RegisterFunction;
import godot.annotation.RegisterSignal;
import godot.core.Callable;
import godot.core.StringNameUtils;
import godot.signals.Signal;
import godot.signals.SignalProvider;

@RegisterClass
public class TabContainerScript extends RavenOptionButton {
    @RegisterSignal
    public Signal tabClicked = SignalProvider.signal(this, "tab_clicked");
    @RegisterSignal
    public Signal tabInit = SignalProvider.signal(this, "tab_init");

    public TabContainerScript() {
        super();
    }

    private boolean canBeConverted(String input) {
        try {
            Integer.parseInt( input );
            return true;
        }
        catch( NumberFormatException e ) {
            return false;
        }
    }

    // We only want to return the values as string if not convertable to numbers..
    private String escapeString(String input) {
        StringBuilder str = new StringBuilder();
        str.append("\"");
        str.append(input);
        str.append("\"");
        return str.toString();
    }
    @RegisterFunction
    public void callbackTabClicked(int num) {
        String callback = (String) this.get(StringNameUtils.asStringName("node_callback"));

        // TODO how to deal with numbers?

        assert callback != null;
        // TODO Assuming callback has only one ^% parameter for now
        // Rascal is accepting strings and then converting to custom types.

        String alteredCallback = callback.replaceAll("%(\\w+)", String.valueOf(num));

        NativeClient.getInstance(
                        "0.0.0.0",
                        23000,
                        getTree().getRoot().getChild(0))
                .send("CALLBACK:" + alteredCallback);
    }

    @RegisterFunction
    public void callbackTabInit(String callback) {
        this.set(StringNameUtils.asStringName("node_callback"),callback);
        this.notifyPropertyListChanged();
    }


    @RegisterFunction
    public void _ready() {
        connect(
                StringNameUtils.asStringName("tab_clicked"),
                new Callable(this, StringNameUtils.asStringName("callback_tab_clicked"))
        );
        connect(
                StringNameUtils.asStringName("tab_init"),
                new Callable(this, StringNameUtils.asStringName("callback_tab_init"))
        );
    }


}
