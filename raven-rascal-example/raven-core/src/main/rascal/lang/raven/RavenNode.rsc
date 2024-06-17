module lang::raven::RavenNode

// Property is something like "Color" or "StyleBox"
data Setting 
  = setting(str property, list[tuple[str property, value val]] setting2)
  | setting(str property, list[Setting] setting1);

alias InlineStyleSetting = list[Setting];
// COmment: Might be that we need a settings thing everywhere to be access it without magic.
public data RavenNode = 
            ravenNode2D(str nodeID, list[RavenNode] children, bool root)
            | ravenNode2D(str nodeID, list[RavenNode] children)
            // Label
            | ravenLabel(str text,list[Setting] settings = [])
            // Control Nodes
            // Button
            | ravenButton(str label, str callback, list[Setting] settings = [])
            | ravenTextEdit(str content,str callback,list[Setting] settings = [] ) 
            | ravenLineEdit(str content,str callback,list[Setting] settings = [] ) 
            // OptionButton
            | ravenOptionButton( list[str] options, str callback, list[Setting] settings = [])
            // Containers
            | ravenHBox( list[RavenNode] children,list[Setting] settings = []  ) 
            | ravenVBox( list[RavenNode] children, list[Setting] settings = [] )
            | ravenTab(str nodeID, str name, list[RavenNode] children,list[Setting] settings = [] )
            | ravenTabContainer(list[RavenNode] children, str callback="",list[Setting] settings = [])
            | ravenPanelContainer(list[RavenNode] children,list[Setting] settings = [])
            | ravenPanel(list[RavenNode] children, list[Setting] settings = [])
            | ravenScrollContainer(list[RavenNode] children,list[Setting] settings = [])
            // Needed for transition of nodes 
            | empty();

