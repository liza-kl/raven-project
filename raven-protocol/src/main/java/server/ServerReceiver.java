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
    private final PrintWriter output;

    ServerReceiver(PrintWriter output,IValueFactory values) {
        this.output = output;
        this.values = values;
        this.evaluator = new Evaluator(values, System.in, System.err, System.out, top, heap);
        this.evaluator.addRascalSearchPath(URIUtil.rootLocation("std"));
        this.evaluator.addRascalSearchPath(URIUtil.correctLocation("file","", "/Users/ekletsko/raven-project/raven-protocol/src/main/resources/rascal-0.33.0.jar" ));
        this.evaluator.addRascalSearchPath(URIUtil.correctLocation("file","","/Users/ekletsko/raven-project/raven-core/src/main/rascal"));
        this.evaluator.doImport(null, "Main");
    }

    @Override
    public void onReceive(String element) {
        //System.out.println(element);
        //System.out.println(this.output);
        //output.println(element);
        //output.flush();
        IString test = this.values.string(element);
        this.evaluator.call(null, "Main", "rascalCallback", test);
    }
}