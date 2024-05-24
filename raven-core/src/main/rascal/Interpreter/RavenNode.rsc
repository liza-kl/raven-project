module Interpreter::RavenNode



public data RavenNode = 
            ravenNode2D(str nodeID, list[RavenNode] children, bool root)
            | ravenNode2D(str nodeID, list[RavenNode] children)
            // Label
            | ravenLabel(str nodeID, str text, int xPosition, int yPosition)
            | ravenLabel(str text)
            // Control Nodes
            // Button
            | ravenButton(str label, str callback)
            | ravenButton(str nodeID, str label, str callback, int xPosition, int yPosition)
            | ravenButton(str nodeID, str label, str callback)
            // GraphNode
            | ravenGraphNode(str nodeID, int xPosition, int yPosition)
            | ravenGraphEditNode(str nodeID, int xPosition, int yPosition, list[RavenNode] children)
            // TODO Is there a way to match this kind of things so we avoid redundancy?
            | ravenTextEdit(str content,str callback) 
            //| ravenTextEdit(str content, str callback, str nodeID=toString(uuidi()), map[str, value]settings=())
          //  | ravenTextEdit(str content,str callback, str nodeID)
          //  | ravenTextEdit(str content,str callback, str nodeID,map[str, value]settings)
            // Visual Arrangement Options
            | ravenGrid(str nodeID, int columns,list[RavenNode] children=[],  map[str, value]settings=())
            | ravenGrid(str nodeID, int columns, int vSeparation, int hSeparation, int xPosition, int yPosition, list[RavenNode] children)
            // OptionButton
            | ravenOptionButton( list[str] options)
            // Containers
            | ravenHBox( list[RavenNode] children) 
            | ravenVBox( list[RavenNode] children)
            | ravenTab(str name, list[RavenNode] children)
            | ravenTabContainer(list[RavenNode] children)
            // Needed for transition of nodes 
            | empty();
