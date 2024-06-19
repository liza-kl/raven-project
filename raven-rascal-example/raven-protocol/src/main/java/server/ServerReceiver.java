package server;

import config.YamlUtil;
import io.usethesource.vallang.IString;
import io.usethesource.vallang.IValueFactory;
import org.apache.commons.lang.StringUtils;
import org.rascalmpl.interpreter.Evaluator;
import org.rascalmpl.interpreter.env.GlobalEnvironment;
import org.rascalmpl.interpreter.env.ModuleEnvironment;
import org.rascalmpl.uri.URIUtil;
import java.io.File;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

class ServerReceiver implements ReceiveCallback {
    private final IValueFactory values;
    private final Evaluator evaluator;
    final GlobalEnvironment heap = new GlobalEnvironment();
    final ModuleEnvironment top = new ModuleEnvironment("app", heap);
    private PrintWriter output;
    private static ServerReceiver instance;

    public ServerReceiver(PrintWriter output, IValueFactory values) {
        YamlUtil config = new YamlUtil("config.yaml");
        this.output = output;
        this.values = values;
        this.evaluator = new Evaluator(values, System.in, System.err, System.out, top, heap);

        this.evaluator.addRascalSearchPath(URIUtil.rootLocation("std"));
        for (String path : config.getRascalSearchPath()) {
            this.evaluator.addRascalSearchPath(URIUtil.correctLocation("file", "", path));
        }

        for (String imp : config.getImports()) {
            this.evaluator.doImport(null, imp);
        }

        // FIXME make that not so weirdly accessed.
        List<Map<String, Object>> mainConfig = config.getMainConfig();
            String module = (String) mainConfig.get(0).get("module");
            String func = (String) mainConfig.get(1).get("func");
            this.evaluator.call(null, module, func);

    }

    public static synchronized ServerReceiver getInstance(PrintWriter output,IValueFactory values) {
        if (instance == null) {
            instance = new ServerReceiver( output, values);
        }
        return instance;
    }

    // Message format: [MESSAGE_TYPE]:[MESSAGE]
    // Code adjusted from https://reintech.io/blog/java-socket-programming-creating-custom-communication-protocols
    @Override
    public void onReceive(String element) {
        //System.out.println("Server received: " + element);

        element = element.startsWith("\"") ?  element.substring(1, element.length() -1) : element;
        element = element.endsWith("\"") ?  element.substring(0, element.length() -1) : element;

        String[] parts = element.split(":", 2);
        if (parts.length != 2) {
           throw new RuntimeException("Invalid message received: " + element);
        }

        String messageType = parts[0];
        //System.out.println("Message type: " + messageType);
        String content = parts[1]
                .replaceAll("/\\S+|\\n/g\n", "")
                .replaceAll("\r", "")
                .replaceAll("\\\\\"", "\"")
                // FIXME this is because of rascal's double escape, but there is a cleaner solution for sure.
                .replaceAll("\\\\\\\"(.*?)\\\\\\\"", "\"$1\"")
                .replaceAll("\\\\n", "");
        //System.out.println("cleaned type: " + content);

        /* This plainly sends a message to Godot to update the whole view.*/
        if (messageType.equals("VIEW_UPDATE")) {
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
            this.evaluator.call(null, "lang::raven::Core", "dispatch", callback);
        }

        else {
            System.out.println("Invalid message received: " + element);
        }
    }
}