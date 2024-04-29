package cwi.masterthesis.raven.application.client;

import godot.Node;
import godot.StreamPeerTCP;
import godot.annotation.RegisterClass;
import godot.annotation.RegisterFunction;
import godot.annotation.RegisterSignal;
import godot.core.Callable;
import godot.core.StringNameUtils;
import godot.core.VariantArray;
import godot.signals.Signal;
import godot.signals.SignalProvider;

// Code adjusted from https://www.bytesnsprites.com/posts/2021/creating-a-tcp-client-in-godot/
@RegisterClass
public class GodotClient extends Node implements Client{
    private static GodotClient client_instance = null;
    private StreamPeerTCP streamPeerTCP;
    private int port;
    private String host;
    private StreamPeerTCP.Status status;

    public GodotClient() {
        super();
    }

    public GodotClient(String host, int port) {
        this.streamPeerTCP = new StreamPeerTCP();
        this.port = port;
        this.host = host;
        status = StreamPeerTCP.Status.STATUS_NONE;
    }

    public static synchronized GodotClient getInstance()
    {
        if (client_instance == null)
            client_instance = new GodotClient("0.0.0.0",23000);

        return client_instance;
    }

    public StreamPeerTCP getStreamPeerTCP() {
        return this.streamPeerTCP;
    }
    public StreamPeerTCP.Status getStatus() {
        this.streamPeerTCP.poll();
        return this.status;
    }

    public void setStatus(StreamPeerTCP.Status status) {
        this.streamPeerTCP.poll();
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
        this.setStatus(StreamPeerTCP.Status.STATUS_CONNECTED);
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
    public void connect() {
        this.setStatus(StreamPeerTCP.Status.STATUS_NONE);
        try {
            System.out.println("Connecting to " + this.host + ":" + this.port);
            this.streamPeerTCP.connectToHost(this.host, this.port);
        } catch (Exception e) {
            emitSignal(StringNameUtils.asStringName("stream_error"));
        }
        System.out.println("Current Connection Status" + this.streamPeerTCP.getStatus());
    }

    @Override
    public void disconnect() {
        // @TODO: Implement
    }

    @RegisterFunction
    public boolean send(String content) {
        System.out.println("Sending data to " + this.host + ":" + this.port);
       if (this.streamPeerTCP.getStatus() != StreamPeerTCP.Status.STATUS_CONNECTED) {
           System.out.println("Error: Stream is not currently connected, data can't be sent");
           return false;
       }
        try {
            this.streamPeerTCP.putUtf8String(content + "\n");
           //this.streamPeerTCP.putString(content);

        } catch (Exception e) {
            System.out.println("Error writing to stream: " + streamError);
            return false;
        }
        return true;
    }

    @Override
    public void virtualProcess() {
        this.getStreamPeerTCP().poll();
        var status = this.getStatus();
        var newStatus = this.getStreamPeerTCP().getStatus();
        if (newStatus != status) {
            this.setStatus(newStatus);
            switch(newStatus) {
                case STATUS_NONE: {
                    System.out.println("Disconnected from host");
                    this.emitSignal(StringNameUtils.asStringName("stream_disconnected"));
                    break;
                }
                case STATUS_CONNECTING: {
                    System.out.println("Connecting to host");
                    break;
                }
                case STATUS_CONNECTED: {
                    System.out.println("Connected to host");
                    this.emitSignal(StringNameUtils.asStringName("stream_connected"));
                    break;
                }
                case STATUS_ERROR: {
                    System.out.println("Error with Socket Stream");
                    this.emitSignal(StringNameUtils.asStringName("stream_error"));
                    break;
                }
            }
        }
        if (status == StreamPeerTCP.Status.STATUS_CONNECTED) {
            var availableBytes = this.getStreamPeerTCP().getAvailableBytes();
            if (availableBytes > 0) {
                System.out.println("Available bytes: " + availableBytes);
                VariantArray data  = this.getStreamPeerTCP().getPartialData(availableBytes);
                try {
                    data.get(0);
                } catch (Exception e) {
                    System.out.println("Error reading data from Stream: " + e.getMessage());
                    this.emitSignal(StringNameUtils.asStringName("stream_error"));
                }
                this.emitSignal(StringNameUtils.asStringName("stream_data"), data.get(1));
            }
        }
    }

    @Override
    public void virtualReady() {
        this.getStreamPeerTCP().poll();
        this.connectClientSignals();
        this.setStatus(this.getStatus());
        this.connect();

    }

}
