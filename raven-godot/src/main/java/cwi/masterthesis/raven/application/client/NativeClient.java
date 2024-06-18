// NativeClient.java
package cwi.masterthesis.raven.application.client;

import godot.Node;
import godot.annotation.RegisterClass;
import godot.global.GD;
import server.Buffer;
import server.ConcurrentLinkedQueueBuffer;
import server.Receiver;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;

@RegisterClass
public class NativeClient extends Node implements Client {
    private static NativeClient instance;
    private static Node mainNode;
    private Socket socket;
    private PrintWriter out;
    private BufferedReader in;

    public NativeClient() {
        super();
    }

    NativeClient(String serverIp, int serverPort, Node mainNode) {
        try {
            Buffer sharedBuffer = new ConcurrentLinkedQueueBuffer();
            socket = new Socket(serverIp, serverPort);
            out = new PrintWriter(socket.getOutputStream(), true);
            in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
            NativeClient.mainNode = mainNode;
            NativeClientReceiver receiverCallback = new NativeClientReceiver(out, mainNode.getChild(0));
            GD.INSTANCE.print("main Node in NativeClient" + mainNode);
            Thread sender = new Thread(new NativeClientSender(sharedBuffer, in));
            sender.setName("Sender Thread of Godot");
            Thread receiver = new Thread(new Receiver(sharedBuffer, receiverCallback));
            sender.setName("Receiver Thread of Godot");
            GD.INSTANCE.print("Starting Sender Thread");
            sender.start();
            GD.INSTANCE.print("Starting Receiver Thread");
            receiver.start();

        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static synchronized NativeClient getInstance(String serverIp, int serverPort, Node mainNode) {
        if (instance == null) {
            instance = new NativeClient(serverIp, serverPort, mainNode);
        }
        return instance;
    }

    @Override
    public void connect() {
        // TODO
    }

    @Override
    public void disconnect() {
        try {
            if (in != null) in.close();
            if (out != null) out.close();
            if (socket != null) socket.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public boolean send(String message) {
        this.out.println(message);
        return true;
    }

    @Override
    public void virtualProcess() {
        // TODO: Implement virtual processing if needed
    }

    @Override
    public void virtualReady() {
        // TODO: Implement virtual ready if needed
    }

    public void close() {
        try {
            socket.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
