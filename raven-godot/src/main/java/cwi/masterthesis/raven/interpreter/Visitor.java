package cwi.masterthesis.raven.interpreter;

import cwi.masterthesis.raven.interpreter.nodes.*;

public interface Visitor {
    void visitButton(RavenButton ravenButton);
    void visitLabel(RavenLabel ravenLabel);
    void visitNode2D(RavenNode2D ravenNode2D);
    void visitGraphNode(RavenGraphNode ravenGraphNode);
    void visitGraphEditNode(RavenGraphEditNode ravenGraphEditNode);
}