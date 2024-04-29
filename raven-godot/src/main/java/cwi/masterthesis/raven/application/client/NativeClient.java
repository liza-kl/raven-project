package cwi.masterthesis.raven.application.client;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;

// Code adjusted from https://www.bytesnsprites.com/posts/2021/creating-a-tcp-client-in-godot/
public class NativeClient implements Client {
    private static NativeClient instance;
    private Socket socket;
    private PrintWriter out;
    private BufferedReader in;

    NativeClient(String serverIp, int serverPort) {
        try {
            socket = new Socket(serverIp, serverPort);
            out = new PrintWriter(socket.getOutputStream(), true);
            in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static NativeClient getInstance(String serverIp, int serverPort) {
        if (instance == null) {
            instance = new NativeClient(serverIp, serverPort);
        }
        return instance;
    }

    @Override
    public void connect() {
        // @TODO implement
    }

    @Override
    public void disconnect() {
        // @TODO implement
    }

    public boolean send(String message) {
        out.println(message);
        try {
            System.out.println("Server response: " + in.readLine());
            return true;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public void virtualProcess() {
        // TODO Do nothing
    }

    @Override
    public void virtualReady() {
        // TODO Do nothing

    }

    public void close() {
        try {
            socket.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}
