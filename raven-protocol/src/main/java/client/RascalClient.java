package client;

import io.usethesource.vallang.IString;
import io.usethesource.vallang.IValueFactory;
import org.rascalmpl.interpreter.Evaluator;
import org.rascalmpl.interpreter.env.GlobalEnvironment;
import org.rascalmpl.interpreter.env.ModuleEnvironment;
import org.rascalmpl.uri.URIUtil;
import server.Server;

import java.io.IOException;
import java.net.Socket;
import static org.rascalmpl.values.ValueFactoryFactory.getValueFactory;

public class RascalClient implements Runnable {
    private final IValueFactory values;
    private final Evaluator evaluator;
    final GlobalEnvironment heap = new GlobalEnvironment();
    final ModuleEnvironment top = new ModuleEnvironment("app", heap);

    // Initialise the server class using the IValueFactory (linking Rascal).
    public RascalClient(IValueFactory values){
        this.values = values;
        this.evaluator = new Evaluator(values, System.in, System.err, System.out, top, heap);
        this.evaluator.addRascalSearchPath(URIUtil.rootLocation("std"));
        this.evaluator.addRascalSearchPath(URIUtil.correctLocation("file","", "/Users/ekletsko/raven-project/raven-protocol/src/main/resources/rascal-0.33.0.jar" ));
        this.evaluator.addRascalSearchPath(URIUtil.correctLocation("file","","/Users/ekletsko/raven-project/raven-core/src/main/rascal"));
        this.evaluator.doImport(null, "lang::raven::Core");
    }

    public void callDispatcher(String arg) {
        System.out.println("this values"+this.values);
        IString callback = this.values.string(arg);
        this.evaluator.call(null, "lang::raven::Core", "dispatch", callback);
    }

    // connect to server
    public void connect() {
        String HOST = "0.0.0.0";
        int PORT = 23000;

        try {
            Socket socket = null;
            socket = new Socket(HOST, PORT);

        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    public void disconnect(Socket socket) throws IOException {
        socket.close();
    }

    @Override
    public void run() {
        this.connect();
    }

    public static void main(String[] args) throws InterruptedException {

    RascalClient client = new RascalClient(getValueFactory());
        client.run();
////      client.callRascal2();
//        client.callRascal("testitest");
    }

}
