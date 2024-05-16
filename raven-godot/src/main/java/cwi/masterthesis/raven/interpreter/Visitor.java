package cwi.masterthesis.raven.interpreter;

import cwi.masterthesis.raven.interpreter.nodes.*;
import cwi.masterthesis.raven.interpreter.nodes.control.*;

public interface Visitor {
    void visitButton(RavenButton ravenButton);
    void visitLabel(RavenLabel ravenLabel);
    void visitNode2D(RavenNode2D ravenNode2D);
    void visitGraphNode(RavenGraphNode ravenGraphNode);
    void visitGraphEditNode(RavenGraphEditNode ravenGraphEditNode);
    void visitTextEdit(RavenTextEdit ravenTextEditNode);
    void visitHBoxContainer(RavenHBoxContainer ravenHBoxContainer);
    void visitVBoxContainer(RavenVBoxContainer ravenVBoxContainer);
    void visitGridContainer(RavenGridContainer ravenGridContainer);
    void visitControl(RavenControl ravenControl);
}