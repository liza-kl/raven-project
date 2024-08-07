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
public class OptionButtonScript extends RavenOptionButton {
    @RegisterSignal
    public Signal itemSelected = SignalProvider.signal(this, "item_selected");
    @RegisterSignal
    public Signal optionInit = SignalProvider.signal(this, "option_init");

    public OptionButtonScript() {
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
    public void callbackOptionSelected(int num) {
        String callback = (String) this.get(StringNameUtils.asStringName("node_callback"));

        // TODO how to deal with numbers?
        //String content = "\"" + this.getText() + "\"";
        String content = this.getText();

        assert callback != null;
        // TODO Assuming callback has only one ^% parameter for now
        // Rascal is accepting strings and then converting to custom types.

        String alteredCallback = callback.replaceAll("%(\\w+)", canBeConverted(content) ?  content : escapeString(content));

        NativeClient.getInstance(
                "0.0.0.0",
                23000,
                getTree().getRoot().getChild(0))
                .send("CALLBACK:" + alteredCallback);
    }

    @RegisterFunction
    public void callbackOptionInit(String callback) {
        this.set(StringNameUtils.asStringName("node_callback"),callback);
        this.notifyPropertyListChanged();
    }


    @RegisterFunction
    public void _ready() {
        connect(
                StringNameUtils.asStringName("item_selected"),
                new Callable(this, StringNameUtils.asStringName("callback_option_selected"))
        );
        connect(
                StringNameUtils.asStringName("option_init"),
                new Callable(this, StringNameUtils.asStringName("callback_option_init"))
        );
    }


}
