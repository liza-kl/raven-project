package server;

import java.net.*;
import java.io.*;

import io.usethesource.vallang.IInteger;
import io.usethesource.vallang.IString;
import io.usethesource.vallang.IValueFactory;
import io.usethesource.vallang.impl.persistent.ValueFactory;

// Inspiration:: https://www.baeldung.com/a-guide-to-java-sockets
public class Server extends Thread {
    private final IValueFactory values;

    // Initialise the server class using the IValueFactory (linking Rascal).
    public Server(IValueFactory values){
        this.values = values;
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

            System.out.println("Server response: " + in.readLine());
            socket.close();
           // return true;
        } catch (IOException e) {
            e.printStackTrace();
           // return false;
        }
    }

    @Override
    // Start the server on port, listening for "ping"  to send back "pong".
    public void run() {
        final int PORT = 23000;
        try (ServerSocket serverSocket = new ServerSocket(PORT)) {
            System.out.println("Server started, waiting for connections...");
            Socket clientSocket = serverSocket.accept();
            System.out.println("Client connected: " + clientSocket);

            var inputStream = clientSocket.getInputStream();
            BufferedReader in = new BufferedReader(new InputStreamReader(inputStream));

            PrintWriter out = new PrintWriter(clientSocket.getOutputStream(), true);

            String inputLine;
            while ((inputLine = in.readLine()) != null) {
                System.out.println("Received from client: " + inputLine);
                out.println("Server received: " + "A nice thingy." + inputLine);
                out.flush();
            }
           clientSocket.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public void startServer() {
        Server server =  new Server(values);
        server.start();
    }
}

// Make rascal read from a buffer -> annoying spin lock
// The thread is knowing best when to do something, notify rascal with a json object to