package cwi.masterthesis.raven.interpreter.nodes.control;

import cwi.masterthesis.raven.files.FileUtils;
import cwi.masterthesis.raven.interpreter.Visitor;
import cwi.masterthesis.raven.interpreter.nodes.RavenNode;
import godot.Button;
import godot.Node;
import godot.annotation.*;
import godot.core.Callable;
import godot.core.StringNameUtils;
import godot.signals.Signal;
import godot.signals.SignalProvider;

@RegisterClass
public class RavenButton extends Button implements RavenNode {
    private String nodeID;
    private Node parentNode;
    private String label;
    private int XCoordinate;
    private int YCoordinate;
    private String callback;


    @RegisterSignal
    public Signal testSignal = SignalProvider.signal(this, "test_signal");

    @RegisterProperty
    public boolean signalEmitted = false;

    @Export
    @RegisterProperty
    public String btnCallback = "a dummy callback";

    @Export
    @RegisterProperty
    public String btnId = "dummy id";

    @RegisterFunction
    public void connectAndTriggerSignal() {
        connect(
                StringNameUtils.asStringName("test_signal"),
                new Callable(this, StringNameUtils.asStringName("signal_callback"))
                //   ConnectFlags.CONNECT_ONE_SHOT.getId()
        );
    }

    @RegisterFunction
    public void signalCallback() {
        System.out.println("a signal was called!");
        FileUtils.deleteFileContent();
        System.out.println("callback: " + btnCallback);
        System.out.println("Written to file");

    }

    public RavenButton() {
        super();
    }

    // TODO make this somehow dynamic
    public RavenButton(String nodeID, Node parentNode, String label, int XCoordinate, int YCoordinate, String callback) {
        this.nodeID = nodeID;
        this.parentNode = parentNode;
        this.label = label;
        this.XCoordinate = XCoordinate;
        this.YCoordinate = YCoordinate;
        this.callback = callback;

    }


    @RegisterFunction
    public void _ready() {
        this.connectAndTriggerSignal();
    }

    @RegisterFunction
    public void _pressed() {
        emitSignal(StringNameUtils.asStringName("test_signal"));

    }

    @Override
    public void acceptVisitor(Visitor visitor) {
        visitor.visitButton(this);
    }

    public Node getParentNode() {
        return parentNode;
    }

    public String getLabel() {
        return label;
    }

    public int getXCoordinate() {
        return XCoordinate;
    }

    public int getYCoordinate() {
        return YCoordinate;
    }

    public String getCallback() {
        return callback;
    }


    public String getNodeID() {
        return nodeID;
    }
}
