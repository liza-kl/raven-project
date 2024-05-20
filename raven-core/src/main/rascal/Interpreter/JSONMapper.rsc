module Interpreter::JSONMapper
import Main;
import Interpreter::RavenNode;
import IO;
import ApplicationConf;
import String;
import List;
import Type;
import Map;
import util::UUID;

public str toString(x) = rvn_print(x);
str rvn_print(int number) = "<number>";
str rvn_print(str string) =  "\"<string>\"";
str rvn_print(list[RavenNode] children: []) = "";

// LABEL
str rvn_print(RavenNode nodeName: ravenLabel( str text)) =
    "\"Label\": {
    '   \"id\": \"<uuidi()>\",
    '   \"text\": <rvn_print(text)>
    '}  ";
   

str rvn_print(RavenNode nodeName: ravenLabel(str nodeID , str text, int xPosition, int yPosition)) =
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

str rvn_print(list[str] options) = "
'<for(str option <- options){>
'{
'   <rvn_print(option)>}<if(!(indexOf(options,option) == size(options) - 1)){>,
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

// TEXTEDIT
str rvn_print(RavenNode nodeName:ravenTextEdit(str content, str callback)) =
    "\"TextEdit\":
    '{
    '   \"id\": \"<uuidi()>\",
    '   \"callback\": \"<callback>\",
    '   \"text\": \"<content>\"
    '}";


// BUTTONS 
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

str rvn_print(RavenNode nodeName:ravenButton(
                                            str buttonText,
                                            str callback)) = 
    "\"Button\":
    '{
    '   \"id\": \"<uuidi()>\",
    '   \"text\": \"<buttonText>\",
    '   \"callback\": \"<callback>\",
    '   \"xPosition\": \"0\",
    '   \"yPosition\": \"0\"
    '}";

// BUTTONS 
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


// VBOXCONTAINER
str rvn_print(RavenNode nodeName:ravenVBox (list[RavenNode] children)) =
 "\"VBoxContainer\":
    '{
    '   \"id\": \"<uuidi()>\",
    <if(children!=[]){>
    '   \"children\":
    '[<rvn_print(children)>
    ']
    '<}> 
    '}";


// HBOXCONTAINER
str rvn_print(RavenNode nodeName:ravenHBox (list[RavenNode] children)) =
 "\"HBoxContainer\":
    '{
    '   \"id\": \"<uuidi()>\",
    <if(children!=[]){>
    '   \"children\":
    '[<rvn_print(children)>
    ']
    '<}> 
    '}";

// TAB CONTAINER 
str rvn_print(RavenNode nodeName:ravenTabContainer(list[RavenNode] children)) =
 "\"TabContainer\":
    '{
    '   \"id\": \"<uuidi()>\",
    <if(children!=[]){>
    '   \"children\":
    '[<rvn_print(children)>
    ']
    '<}> 
    '}";

// TABS 
str rvn_print(RavenNode nodeName:ravenTab(str name, list[RavenNode] children)) =
 "\"Tab\":
    '{
    '   \"id\": \"<uuidi()>\",
    '   \"name\": \"<name>\",
    <if(children!=[]){>
    '   \"children\":
    '[<rvn_print(children)>
    ']
    '<}> 
    '}";


// OPTION BUTTON
str rvn_print(RavenNode nodeName:ravenOptionButton(list[str] options)) =
 "\"OptionButton\":
    '{
    '   \"id\": \"<uuidi()>\",
    <if(options!=[]){>
    '   \"options\":
    '[<rvn_print(options)>
    ']
    '<}> 
    '}";


// MISC Functions
RavenNode mapNodesToJSON(RavenNode tree) =  top-down-break visit(tree){      
    case RavenNode tree : JSON_CONTENT += rvn_print(tree);
};

public void genJSON(RavenNode tree) {
    mapNodesToJSON(tree);
    writeFile(JSON_TREE_FILE, JSON_CONTENT);
}

