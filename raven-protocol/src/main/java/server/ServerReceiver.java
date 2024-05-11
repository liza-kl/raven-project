package server;

import java.io.PrintWriter;

class ServerReceiver implements ReceiveCallback {

    private final PrintWriter output;

    ServerReceiver(PrintWriter output) {
        this.output = output;
    }

    @Override
    public void onReceive(String element) {
        System.out.println(element);
        output.flush();
    }
}