module Interpreter::RavenNodes
import Main;
import IO;
import ApplicationConf;
import String;
import List;
import Type;
import Map;
import util::UUID;
// Rascal Tree -> JSON -> Feed into Java -> Create Custom Format to parse it better -> Create Scene in Godot 
// Passing JSON tree as argument in makefile?
// Partial functions and recursive connection, you can just use the cases and then recursively until
// you see the base case goes with children = [];
// String template in rascal 
// https://github.com/vrozen/Cascade/blob/main/TEL/src/lang/tel/Printer.rsc


public data RavenNode = 
            ravenNode2D(str nodeID, list[RavenNode] children, bool root)
            | ravenNode2D(str nodeID, list[RavenNode] children)
            | ravenLabel(str nodeID, str text, int xPosition, int yPosition)
            // Control Nodes 
            | ravenControlNode(str nodeID, list[RavenNode] children)
            | ravenButton(str nodeID, str label, str callback, int xPosition, int yPosition)
            | ravenButton(str nodeID, str label, str callback)
            | ravenGraphNode(str nodeID, int xPosition, int yPosition)
            | ravenGraphEditNode(str nodeID, int xPosition, int yPosition, list[RavenNode] children)
            // TODO Is there a way to match this kind of things?
            | ravenTextEdit(str content, str callback, str nodeID=toString(uuidi()), map[str, value]settings=())
            | ravenTextEdit(str content,str callback, str nodeID)
            | ravenTextEdit(str content,str callback, str nodeID,map[str, value]settings)
            | ravenTextEdit(str content,str callback)
            // Visual Arrangement Options
            | ravenGrid(str nodeID, int columns,list[RavenNode] children=[],  map[str, value]settings=())
            | ravenGrid(str nodeID, int columns, int vSeparation, int hSeparation, int xPosition, int yPosition, list[RavenNode] children);
            

public str toString(x) = rvn_print(x);
str rvn_print(int number) = "<number>";
str rvn_print(str string) =  "\"<string>\"";
str rvn_print(list[RavenNode] children: []) = "";

str rvn_print(RavenNode nodeName: ravenLabel(str nodeID, str text, int xPosition, int yPosition)) =
    "\"Label\": {
    '   \"id\": <rvn_print(nodeID)>,
    '   \"text\": <rvn_print(text)>,
    '   \"xPosition\": <rvn_print(xPosition)>,
    '   \"yPosition\": <rvn_print(yPosition)>
    '}  ";
   
str rvn_print(RavenNode nodeName:ravenNode2D(str nodeID, list[RavenNode] children,true)) = 
    "\"id\": <rvn_print(nodeID)><if(children!=[]){>,
    '   \"children\":
    '[<rvn_print(children)>
    ']
    '<}>";

str rvn_print(RavenNode nodeName:ravenNode2D(str nodeID, list[RavenNode] children)) = 
    "\"Node2D\": {
    '\"id\": <rvn_print(nodeName.nodeID)><if(children!=[]){>,
    '   \"children\":
    '[<rvn_print(children)>
    ']
    '<}> 
    '}  ";
   

// JSON cant have duplicate keys, very sad.
str rvn_print(list[RavenNode] children) = "
'<for(RavenNode child <- children){>
'{
'   <rvn_print(child)>}<if(!(indexOf(children,child) == size(children) - 1)){>,
'<}>
<}>
";

str rvn_print(map[str, value] settings) = "
'   settings: {
'       <for(str settingKey <- domain(settings)){ 
        value val = settings[settingKey];>
'       \"<settingKey>\" : \"<val>\"<if(settingKey != last( [elem | elem <- domain(settings)])){>,
'<}>
' }
<}>          
";
default str rvn_print(RavenNode ravenNode) { throw "you forgot a case <typeOf(ravenNode)>"; } 

str rvn_print(RavenNode nodeName:ravenButton(str nodeID,
                                            str buttonText,
                                            str callback,
                                            int xPosition,
                                            int yPosition)) = 
    "\"Button\":
    '{
    '   \"id\": \"<nodeID>\",
    '   \"text\": \"<buttonText>\",
    '   \"callback\": \"<callback>\",
    '   \"xPosition\": \"<xPosition>\",
    '   \"yPosition\": \"<yPosition>\"
    '}";

/* TODO How to deal with the x y position if they are not set */
str rvn_print(RavenNode nodeName:ravenButton(str nodeID,
                                            str buttonText,
                                            str callback)) = 
    "\"Button\":
    '{
    '   \"id\": \"<nodeID>\",
    '   \"text\": \"<buttonText>\",
    '   \"callback\": \"<callback>\",
    '   \"xPosition\": \"0\",
    '   \"yPosition\": \"0\"
    '}";


str rvn_print(RavenNode nodeName:ravenGraphEditNode(str nodeID,
                                                    int xPosition,
                                                    int yPosition,
                                                    list[RavenNode]  children)) =
    "\"GraphEditNode\":
    '{
    '   \"id\": \"<nodeID>\",
    '   \"xPosition\": \"<xPosition>\",
    '   \"yPosition\": \"<yPosition>\",
    <if(children!=[]){>
    '   \"children\":
    '[<rvn_print(children)>
    ']
    '<}> 
    '}";

str rvn_print(RavenNode nodeName:ravenGraphNode(str nodeID,
                                                int xPosition,
                                                int yPosition)) =
    "\"GraphNode\":
    '{
    '   \"id\": \"<nodeID>\",
    '   \"xPosition\": \"<xPosition>\",
    '   \"yPosition\": \"<yPosition>\"
    '}";

str rvn_print(RavenNode nodeName:ravenGrid(str nodeID,
                                            int columns,
                                            int vSeparation,
                                            int hSeparation,
                                            int xPosition,
                                            int yPosition,
                                            list[RavenNode] children)) =
 "\"GridContainer\":
    '{
    '   \"id\": \"<nodeID>\",
    '   \"columns\": \"<columns>\",    
    '   \"vSeparation\": \"<vSeparation>\",    
    '   \"hSeparation\": \"<hSeparation>\",    
    '   \"xPosition\": \"<xPosition>\",
    '   \"yPosition\": \"<yPosition>\",
    <if(children!=[]){>
    '   \"children\":
    '[<rvn_print(children)>
    ']
    '<}> 
    '}";

str rvn_print(RavenNode nodeName:ravenTextEdit(str content, str callback)) =
    "\"TextEdit\":
    '{
    '   \"id\": \"<uuidi()>\",
    '   \"callback\": \"<callback>\",
    '   \"text\": \"<content>\"
    '}";

str rvn_print(RavenNode nodeName:ravenTextEdit(str content, str nodeID)) =
    "\"TextEdit\":
    '{
    '   \"id\": \"<nodeID>\",
    '   \"text\": \"<content>\"
    '}";


str rvn_print(RavenNode nodeName:ravenTextEdit(str content,
                                                str nodeID,
                                                str callback, 
                                                map[str, value] settings)) =
    "\"TextEdit\":
    '{
    '   \"id\": \"<nodeID>\",
    '   \"text\": \"<content>\"<if(!isEmpty(nodeName.settings)){>,
    '<rvn_print(nodeName.settings)>  
    '<}>
    '}";

RavenNode mapNodesToJSON(RavenNode tree) =  top-down-break visit(tree){      
    case RavenNode tree : JSON_CONTENT += rvn_print(tree);
};

public void genJSON(RavenNode tree) {
    mapNodesToJSON(tree);
    writeFile(JSON_TREE_FILE, JSON_CONTENT);
}

