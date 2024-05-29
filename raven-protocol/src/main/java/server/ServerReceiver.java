package server;

import io.usethesource.vallang.IString;
import io.usethesource.vallang.IValueFactory;
import org.rascalmpl.interpreter.Evaluator;
import org.rascalmpl.interpreter.env.GlobalEnvironment;
import org.rascalmpl.interpreter.env.ModuleEnvironment;
import org.rascalmpl.uri.URIUtil;

import java.io.PrintWriter;

class ServerReceiver implements ReceiveCallback {
    private final IValueFactory values;
    private final Evaluator evaluator;
    final GlobalEnvironment heap = new GlobalEnvironment();
    final ModuleEnvironment top = new ModuleEnvironment("app", heap);
    private PrintWriter output;

    ServerReceiver(PrintWriter output,IValueFactory values) {
        this.output = output;
        this.values = values;
        this.evaluator = new Evaluator(values, System.in, System.err, System.out, top, heap);
        this.evaluator.addRascalSearchPath(URIUtil.rootLocation("std"));
        this.evaluator.addRascalSearchPath(URIUtil.correctLocation("file","", "/Users/ekletsko/raven-project/raven-protocol/src/main/resources/rascal-0.33.0.jar" ));
        this.evaluator.addRascalSearchPath(URIUtil.correctLocation("file","","/Users/ekletsko/raven-project/raven-core/src/main/rascal"));
        this.evaluator.doImport(null, "Main");
        this.evaluator.doImport(null, "lang::sml::control::REPL");
    }

    public void importSomething(IString module) {
        this.evaluator.doImport(null, String.valueOf(module));
    }
    // Message format: [MESSAGE_TYPE]:[MESSAGE]
    // Code adjusted from https://reintech.io/blog/java-socket-programming-creating-custom-communication-protocols
    @Override
    public void onReceive(String element) {
        System.out.println("Server received: " + element);

        String[] parts = element.split(":", 2);
        if (parts.length != 2) {
           throw new RuntimeException("Invalid message received: " + element);
        }

        String messageType = parts[0].startsWith("\"") ? parts[0].substring(1) : parts[0];
        String content = parts[1];

        /* This plainly sends a message to Godot to update the whole view.*/
        if (messageType.equals("VIEW_UPDATE")) {
            System.out.println("im here");

            output.println("VIEW_UPDATE:" + content);
            output.flush();
        }

        else if (messageType.equals("THEME_INIT")) {
            output.println("THEME_INIT:" + content);
            output.flush();
        }

        /* This tells the server to call a Rascal callback */
        else if (messageType.equals("CALLBACK")) {
            IString callback = this.values.string(content); // Also includes arguments
            this.evaluator.call(null, "Main", "rascalCallback", callback);
        }

        else {
            System.out.println("Invalid message received: " + element);
        }
    }
}