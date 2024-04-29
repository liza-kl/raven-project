package cwi.masterthesis.raven.application;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;

// Code adjusted from https://www.bytesnsprites.com/posts/2021/creating-a-tcp-client-in-godot/
public class NativeClient {
    private static NativeClient instance;
    private Socket socket;
    private PrintWriter out;
    private BufferedReader in;

    private NativeClient(String serverIp, int serverPort) {
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

    public void send(String message) {
        out.println(message);
        try {
            System.out.println("Server response: " + in.readLine());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public void close() {
        try {
            socket.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}
