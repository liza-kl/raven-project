package cwi.masterthesis.raven.application;

import godot.Node;
import godot.StreamPeerTCP;
import godot.annotation.RegisterClass;
import godot.annotation.RegisterFunction;
import godot.annotation.RegisterSignal;
import godot.core.Callable;
import godot.core.PackedByteArray;
import godot.core.StringNameUtils;
import godot.signals.Signal;
import godot.signals.SignalProvider;

import java.util.stream.Stream;

// Code adjusted from https://www.bytesnsprites.com/posts/2021/creating-a-tcp-client-in-godot/
@RegisterClass
public class Client extends Node {
    private static Client client_instance = null;
    private StreamPeerTCP streamPeerTCP;
    private final int port;
    private final String host;
    protected StreamPeerTCP.Status status = StreamPeerTCP.Status.STATUS_NONE;

    public Client(String host, int port) {
        this.streamPeerTCP = new StreamPeerTCP();
        this.port = port;
        this.host = host;
    }

    public Client(StreamPeerTCP streamPeerTCP) {
        this.streamPeerTCP = streamPeerTCP;
        this.port = 23000;
        this.host = "0.0.0.0";
    }

    public Client() {
        this.streamPeerTCP = new StreamPeerTCP();
        this.port = 23000;
        this.host = "0.0.0.0";
    }
    public static synchronized Client getInstance()
    {
        if (client_instance == null)
            client_instance = new Client();

        return client_instance;
    }

    public StreamPeerTCP getStreamPeerTCP() {
        return this.streamPeerTCP;
    }
    public StreamPeerTCP.Status getStatus() {
        return this.status;
    }

    public void setStatus(StreamPeerTCP.Status status) {
        this.status = status;
    }

    @RegisterSignal
    public Signal streamConnected = SignalProvider.signal(this, "stream_connected");
    @RegisterSignal
    public Signal streamData = SignalProvider.signal(this, "stream_data");
    @RegisterSignal
    public Signal streamError = SignalProvider.signal(this, "stream_error");
    @RegisterSignal
    public Signal streamDisconnected = SignalProvider.signal(this, "stream_disconnected");

    @RegisterFunction
    public void connectClientSignals() {
        // TODO Rewrite that with a HashMap / Constants
        String[] eventNames = {"stream_connected", "stream_data", "stream_error", "stream_disconnected"};
        String[] callbackNames = {"callback_connected", "callback_data", "callback_error", "callback_disconnected"};
        for (int i = 0; i < eventNames.length; i++) {
            connect(
                    StringNameUtils.asStringName(eventNames[i]),
                    new Callable(this, StringNameUtils.asStringName(callbackNames[i]))
            );
        }
    }

    @RegisterFunction
    public void callbackConnected() {
        System.out.println("Client is successfully connected to server");
    }

    @RegisterFunction
    public void callbackDisconnected() {
        System.out.println("Client is disconnected from server");
    }

    @RegisterFunction
    public void callbackData() {
        System.out.println("There is some data");
    }

    @RegisterFunction
    public void callbackError() {
        System.out.println("An error appeared");
    }

    @RegisterFunction
    public void connectToHost() {
        System.out.println("Connecting to " + this.host + ":" + this.port);
        this.setStatus(StreamPeerTCP.Status.STATUS_NONE);
        try {
            this.streamPeerTCP.connectToHost(this.host, this.port);
        } catch (Exception e) {
            e.printStackTrace();
            emitSignal(StringNameUtils.asStringName("stream_error"));
        }
        System.out.println("Current Connection Status" + this.streamPeerTCP.getStatus());
    }

    @RegisterFunction
    public boolean send(PackedByteArray content) {
       if (this.streamPeerTCP.getStatus() != StreamPeerTCP.Status.STATUS_CONNECTED) {
           System.out.println("Error: Stream is not currently connected, data can't be sent");
           return false;
       }
        try {
            this.streamPeerTCP.putData(content);

        } catch (Exception e) {
            System.out.println("Error writing to stream: " + streamError);
            return false;
        }
        return true;
    }



}