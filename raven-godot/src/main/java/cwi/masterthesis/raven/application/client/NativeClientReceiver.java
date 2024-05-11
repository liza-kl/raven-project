package cwi.masterthesis.raven.application.client;

import godot.Node;
import godot.annotation.RegisterClass;
import godot.core.StringNameUtils;
import godot.global.GD;
import server.ReceiveCallback;

import java.io.PrintWriter;

@RegisterClass
public class NativeClientReceiver extends Node implements ReceiveCallback {
    private Node mainNode = null;
    private  PrintWriter output = null;

    public NativeClientReceiver(PrintWriter output, Node mainNode) {
        this.output = output;
        this.mainNode = mainNode;
    }
    public  NativeClientReceiver() {
        super();
    }

    @Override
    public void onReceive(String element) {
        GD.INSTANCE.print("New element received Client: " + element);
      //
        // TODO FIX THE JSON FORMATTING.
       // mainNode.callDeferred(StringNameUtils.asStringName("callback_update_scene"), element);
       // String cleanedElement = element.replaceAll("\\\\n", "\n").replaceAll("\\\\", "");
       var cleanedElement = element.substring(1, element.length() - 1);
       cleanedElement = cleanedElement.replaceAll("\\\\\"", "\"");
       cleanedElement = cleanedElement.replaceAll("\\\\n", "\n");



        mainNode.callDeferred(StringNameUtils.asStringName("emit_signal"),
                StringNameUtils.asStringName("main_update_scene"), cleanedElement);
        //mainNode.emitSignal(StringNameUtils.asStringName("main_update_scene"), element);
       // mainNode.callDeferred(StringNameUtils.asStringName("emit_"), element);
       // traverseJSON(element, mainNode);

    }
}
