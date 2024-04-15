package cwi.masterthesis.raven.client;


import io.usethesource.vallang.IInteger;
import io.usethesource.vallang.IString;
import io.usethesource.vallang.IValueFactory;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;

// Code taken from https://github.com/reijne/linco-puvi/blob/main/src/Network/Client.java

public class ClientUtils {
    private final IValueFactory values;
    private Socket clientSocket;
    private PrintWriter out;
    private BufferedReader in;

    // Initialise the Client with the valuefactory (link to Rascal).
    public ClientUtils(IValueFactory values){
        this.values = values;
    }

    // Start the client by connecting to the ip+port.
    public void  startClient(IString ip, IInteger port) throws IOException {
        String ipString = ip.getValue();
        int portInteger = port.intValue();
        clientSocket = new Socket(ipString, portInteger);
        out = new PrintWriter(clientSocket.getOutputStream(), true);
        in = new BufferedReader(new InputStreamReader(clientSocket.getInputStream()));
    }

    // Send a message to the connected server and return the response.
    public IString sendMessage(IString msg) throws IOException {
        String msgString = msg.getValue();
        out.println(msgString);
        return values.string("");
    }

    // Stop the client by closing the streams and connection.
    public void stopClient() throws IOException {
        in.close();
        out.close();
        clientSocket.close();
    }
}