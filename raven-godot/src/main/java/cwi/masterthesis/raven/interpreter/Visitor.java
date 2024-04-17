package cwi.masterthesis.raven.interpreter;

import cwi.masterthesis.raven.interpreter.nodes.RavenButton;
import cwi.masterthesis.raven.interpreter.nodes.RavenLabel;
import cwi.masterthesis.raven.interpreter.nodes.RavenNode2D;

public interface Visitor {
    void visitButton(RavenButton ravenButton);
    void visitLabel(RavenLabel ravenLabel);
    void visitNode2D(RavenNode2D ravenNode2D);
}