module lang::raven::RavenNode

// Property is something like "Color" or "StyleBox"
data Setting = setting(str property, list[tuple[str property, value val] settings]);
alias InlineStyleSetting = list[Setting];

public data RavenNode = 
            ravenNode2D(str nodeID, list[RavenNode] children, bool root)
            | ravenNode2D(str nodeID, list[RavenNode] children)
            // Label
            | ravenLabel(str text,list[Setting] styles)
            | ravenLabel(str text)
            // Control Nodes
            // Button
            | ravenButton(str label, str callback)
            | ravenButton(str nodeID, str label, str callback)
            // GraphNode
            | ravenGraphNode(str nodeID, int xPosition, int yPosition)
            | ravenGraphEditNode(str nodeID, int xPosition, int yPosition, list[RavenNode] children)
            // TODO Is there a way to match this kind of things so we avoid redundancy?
            | ravenTextEdit(str content,str callback) 
            // Visual Arrangement Options
            | ravenGrid(str nodeID, int columns,list[RavenNode] children=[],  map[str, value]settings=())
            | ravenGrid(str nodeID, int columns, int vSeparation, int hSeparation, int xPosition, int yPosition, list[RavenNode] children)
            // OptionButton
            | ravenOptionButton( list[str] options)
            | ravenOptionButton( list[str] options, str callback)
            | ravenOptionButton( list[str] options, str callback, list[Setting] styles)
            // Containers
            | ravenHBox( list[RavenNode] children) 
            | ravenVBox( list[RavenNode] children)
            | ravenTab(str nodeID, str name, list[RavenNode] children)
            | ravenTabContainer(list[RavenNode] children)
            | ravenTabContainer(list[RavenNode] children, list[Setting] settings)
            | ravenTabContainer(list[RavenNode] children, str callback, list[Setting] settings)
            | ravenPanelContainer(list[RavenNode] children,list[Setting] settings = [])
            | ravenScrollContainer(list[RavenNode] children,list[Setting] settings = [])
            // Needed for transition of nodes 
            | empty();

