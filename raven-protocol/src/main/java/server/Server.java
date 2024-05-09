package server;

import java.net.*;
import java.io.*;

import io.usethesource.vallang.*;
import io.usethesource.vallang.impl.persistent.ValueFactory;

public class Server extends Thread {
    private static Server instance;
    private final IValueFactory values;
    private ServerSocket serverSocket;
    private boolean isRunning = false;

    public Server(IValueFactory values) {
        this.values = values;
        if (instance != null) {
            throw new IllegalStateException("Singleton instance already exists");
        }
        instance = this;
    }

    public static synchronized Server getInstance() {
        if (instance == null) {
            throw new IllegalStateException("Singleton instance has not been initialized");
        }
        return instance;
    }

    public void setRunning(boolean running) {
        isRunning = running;
    }

    public static synchronized Server getInstance(IValueFactory values) {
        if (instance == null) {
            instance = new Server(values);
        }
        return instance;
    }

    public void startServer() {
        try {
            final int PORT = 23000;
            serverSocket = new ServerSocket(PORT);
            System.out.println("Server started, waiting for connections...");
            this.setRunning(true);
            this.start();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public void send(IString message) throws IOException {
        System.out.println("I am sending a message");
        Socket socket = null;
        String messageValue = message.toString();
        try {
            socket = new Socket("0.0.0.0", 23000);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        PrintWriter out = new PrintWriter(socket.getOutputStream(), true);
        BufferedReader in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
        out.println(messageValue);
        try {
            socket.close();
            // return true;
        } catch (IOException e) {
            e.printStackTrace();
            // return false;
        }
    }

    @Override
    public void run() {
        Buffer sharedBuffer = new Buffer();

        try {
            while (isRunning) {
                Socket clientSocket = serverSocket.accept();
                System.out.println("Client connected: " + clientSocket.getRemoteSocketAddress());
                BufferedReader in = new BufferedReader(new InputStreamReader(clientSocket.getInputStream()));
                PrintWriter out = new PrintWriter(clientSocket.getOutputStream(), true);
                ServerReceiver receiverCallback = new ServerReceiver(out);
                Thread sender = new Thread(new Sender(sharedBuffer, in));
                Thread receiver = new Thread(new Receiver(sharedBuffer, receiverCallback));
                sender.setName("Sender Thread of Server");
                receiver.setName("Receiver Thread of Server");

                sender.start();
                receiver.start();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public void stopServer() {
        this.setRunning(false);
        try {
            if (serverSocket != null) {
                serverSocket.close();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) throws InterruptedException {
        IValueFactory values = ValueFactory.getInstance();
        Server server = new Server(values);
        server.startServer();
    }
}
