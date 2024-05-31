package server;

import java.net.*;
import java.io.*;

import io.usethesource.vallang.*;
import io.usethesource.vallang.impl.persistent.ValueFactory;

import static org.rascalmpl.values.ValueFactoryFactory.getValueFactory;

public class Server extends Thread {
    private static Server instance;
    private final IValueFactory values;
    private ServerSocket serverSocket;
    private boolean isRunning = false;
    private final Buffer sharedBuffer = new ConcurrentLinkedQueueBuffer();
    private PrintWriter godotOut;



    public Server(IValueFactory values) {
        this.values = values;
        /* if (instance != null) {
            throw new IllegalStateException("Instance already exists");
        }
        instance = this; */
    }

    public void setRunning(boolean running) {
        isRunning = running;
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


    public void send(IString message){
        System.out.println("I am sending a message");
        String HOST = "0.0.0.0";
        int PORT = 23000;

        try {
            Socket socket = null;
            socket = new Socket(HOST, PORT);
            PrintWriter out = new PrintWriter(socket.getOutputStream(), true);
            out.println(message.toString());

        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void run() {
        try {
            while (isRunning) {
                Socket clientSocket = serverSocket.accept();
                System.out.println("Client connected: " + clientSocket.getRemoteSocketAddress());
                BufferedReader in = new BufferedReader(new InputStreamReader(clientSocket.getInputStream()));
                PrintWriter out = new PrintWriter(clientSocket.getOutputStream(), true);
                this.setGodotOut(out);
                ServerReceiver receiverCallback = ServerReceiver.getInstance(this.getGodotOut(), getValueFactory());
                Thread sender = new Thread(new Sender(this.sharedBuffer, in));
                Thread receiver = new Thread(new Receiver(this.sharedBuffer, receiverCallback));
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

    private void setGodotOut(PrintWriter godotOut) {
        this.godotOut = (this.godotOut == null) ? godotOut : this.godotOut;

    }

    private PrintWriter getGodotOut() {
        return this.godotOut;
    }
}
