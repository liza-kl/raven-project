package cwi.masterthesis.raven.application.client;

import godot.global.GD;
import server.ReceiveCallback;

import java.io.PrintWriter;

public class NativeClientReceiver implements ReceiveCallback {
    private final PrintWriter output;

    public NativeClientReceiver(PrintWriter output) {
        this.output = output;
    }

    @Override
    public void onReceive(String element) {
        GD.INSTANCE.print("New element received Client: " + element);
    }
}
