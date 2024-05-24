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

        String[] parts = element.split(":", 2);
        if (parts.length != 2) {
            throw new RuntimeException("Invalid message received: " + element);
        }

        String messageType = parts[0].startsWith("\"") ? parts[0].substring(1) : parts[0];
        System.out.println(messageType);
        String content = parts[1];

        String cleanedElement = content.substring(0, content.length() - 1);
        cleanedElement = cleanedElement.replaceAll("\\\\\"", "\"");
        cleanedElement = cleanedElement.replaceAll("\\\\n", "\n");

        switch (messageType) {
            case "THEME_INIT": {
                mainNode.callDeferred(StringNameUtils.asStringName("emit_signal"),
                        StringNameUtils.asStringName("main_init_general_theme"),cleanedElement);
                break;
            }
            case "VIEW_UPDATE": {
                mainNode.callDeferred(StringNameUtils.asStringName("emit_signal"),
                        StringNameUtils.asStringName("main_update_scene"), cleanedElement);
                break;
            }
            default: {
                GD.INSTANCE.print("A problem appearead");
            }
        }

    }
}
