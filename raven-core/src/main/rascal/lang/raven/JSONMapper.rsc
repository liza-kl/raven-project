module lang::raven::JSONMapper
import lang::raven::RavenNode;
import IO;
import ApplicationConf;
import String;
import List;
import Type;
import Map;
import util::UUID;
import Node;

public str JSON_CONTENT_START = "{";
public str JSON_CONTENT = "";
public str JSON_CONTENT_END = "}";

/* 
* This function is a helper function to help matching with keyword parameters 
* https://www.rascal-mpl.org/docs/Rascal/Declarations/AlgebraicDataType/#examples
*/ 
public bool isKeywordArgDefined (RavenNode n, &T arg) {
    println("checking the keyword <n>");
    println(arg in getKeywordParameters(n));
    return arg in getKeywordParameters(n);
}
public str toString(x) = rvn_print(x);
str rvn_print(int number) = "<number>";
str rvn_print(str string) =  "\"<string>\"";
str rvn_print(list[RavenNode] children: []) = "";
str rvn_print(list[RavenNode] children: [empty()]) = "";
str rvn_print(list[Setting] settings: []) = "";

str rvn_print(list[Setting] settings) = 
"
'<for(Setting child <- settings){>
'{
'   <rvn_print(child)>}<if(!(indexOf(settings,child) == size(settings) - 1) && !(List::last(settings) == child)){>,
'<}>
<}>";

str rvn_print(list[tuple[str property, value val]] styles) = "
'<for(style <- styles){>
'   \"<style.property>\": \"<style.val>\"<if(!(indexOf(styles,style) == size(styles) - 1) && !(List::last(styles) == style)){>,
'<}>
<}>
"; 

str rvn_print(Setting setting: setting(str property, list[tuple[str property, value val]] setting2)) = 
"\"<property>\": {
    '   <rvn_print(setting2)>
    '}  ";

str rvn_print(Setting setting: setting(str property, list[Setting] setting1)) = 
"\"<property>\": 
    '   <rvn_print(setting1)>
    '  ";



// EMPTY
str rvn_print(RavenNode nodeName: empty()) =
    "";
   
// LABEL
str rvn_print(RavenNode nodeName: ravenLabel(str text)) =
    "\"Label\": {
    '   \"id\": \"<uuidi()>\",
    '   \"text\": <rvn_print(text)>
    '<if(isKeywordArgDefined(nodeName, "settings")){>,
    \"styles\": [
    '<rvn_print(getKeywordParameters(nodeName)["settings"])>
    ']
    '<}>
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
   

/* 
* Temporary solution, because prior to that of call by value 
* JSON cant have duplicate keys, very sad
* TODO add generic print, with passing function as parameter.
*/ 
str rvn_print(list[RavenNode] children) {
    str result = "";
    list[RavenNode] curr = children;

    while(size(headTail(curr)[1]) > 0) {
        result += "{";
        result += rvn_print(curr[0]);
        result += "}";
        result += ",";
        curr = headTail(curr)[1];
    };
    result += "{";
    result += rvn_print(headTail(curr)[0]);
    result += "}";
    return result; 
}


/* 
* Temporary solution, because prior to that of call by value 
*/ 
str rvn_print(list[str] options) {
    str result = "";
    list[str] curr = options;

    while(size(headTail(curr)[1]) > 0) {
        result += rvn_print(curr[0]);
        result += ",";
        curr = headTail(curr)[1];
    };
    result += rvn_print(headTail(curr)[0]);
    return result; 
}

str rvn_print(map[str, value] settings) = "
'   settings: {
'       <for(str settingKey <- domain(settings)){ 
        value val = settings[settingKey];>
'       \"<settingKey>\" : \"<val>\"<if(settingKey != last( [elem | elem <- domain(settings)])){>,
'<}>
' }
<}>          
";

// TEXTEDIT
str rvn_print(RavenNode nodeName:ravenTextEdit(str content, str callback)) =
    "\"TextEdit\":
    '{
    '   \"id\": \"<uuidi()>\",
    '   \"callback\": \"<callback>\",
    '   \"text\": \"<content>\"
    '<if(isKeywordArgDefined(nodeName, "settings")){>,
    \"styles\": [
    '<rvn_print(getKeywordParameters(nodeName)["settings"])>
    ']
    '<}>
    '}";

// LINEEDIT
str rvn_print(RavenNode nodeName:ravenLineEdit(str content, str callback)) =
    "\"LineEdit\":
    '{
    '   \"id\": \"<uuidi()>\",
    '   \"callback\": \"<callback>\",
    '   \"text\": \"<content>\"
    '<if(isKeywordArgDefined(nodeName, "settings")){>,
    \"styles\": [
    '<rvn_print(getKeywordParameters(nodeName)["settings"])>
    ']
    '<}>
    '}";



// BUTTONS 
str rvn_print(RavenNode nodeName:ravenButton(str nodeID,
                                            str buttonText,
                                            str callback)) = 
    "\"Button\":
    '{
    '   \"id\": \"<nodeID>\",
    '   \"text\": \"<buttonText>\",
    '   \"callback\": \"<callback>\"
    '}";

/* TODO How to deal with the x y position if they are not set */
str rvn_print(RavenNode nodeName:ravenButton(str nodeID,
                                            str buttonText,
                                            str callback)) = 
    "\"Button\":
    '{
    '   \"id\": \"<nodeID>\",
    '   \"text\": \"<buttonText>\",
    '   \"callback\": \"<callback>\"
    '}";

str rvn_print(RavenNode nodeName:ravenButton(
                                            str buttonText,
                                            str callback)) = 
    "\"Button\":
    '{
    '   \"id\": \"<uuidi()>\",
    '   \"text\": \"<buttonText>\",
    '   \"callback\": \"<callback>\"
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
    '   \"id\": \"<uuidi()>\"<if(children!=[]){>,
    '   \"children\":
    '[<rvn_print(children)>
    ']
    '<}> 
    '}";


// HBOXCONTAINER
str rvn_print(RavenNode nodeName:ravenHBox (list[RavenNode] children)) =
 "\"HBoxContainer\":
    '{
    '   \"id\": \"<uuidi()>\"<if(children!=[]){>,
    '   \"children\":
    '[<rvn_print(children)>
    ']
    '<}> 
    '}";

// TAB CONTAINER 
str rvn_print(RavenNode nodeName:ravenTabContainer(list[RavenNode] children)) =
 "\"TabContainer\":
    '{
    '   \"id\": \"<uuidi()>\"
    <if(children!=[]){>,
    '   \"children\":
    '[<rvn_print(children)>
    ']
    '<}> 
    '}";

str rvn_print(RavenNode nodeName:ravenTabContainer(list[RavenNode] children, list[Setting] settings)) =
 "\"TabContainer\":
    '{
    '   \"id\": \"<uuidi()>\"
    '<if(isKeywordArgDefined(nodeName, "settings")){>,
    \"styles\": [
    '<rvn_print(getKeywordParameters(nodeName)["settings"])>
    ']
    '<}>  
    <if(children!=[]){>,
    '   \"children\":
    '[<rvn_print(children)>
    ']
    '<}> 
    '}";


str rvn_print(RavenNode nodeName:ravenTabContainer(list[RavenNode] children, str callback, list[Setting] settings)) =
 "\"TabContainer\":
    '{
    '   \"id\": \"<uuidi()>\",
    '   \"callback\": \"<callback>\"
    '<if(isKeywordArgDefined(nodeName, "settings")){>,
    \"styles\": [
    '<rvn_print(getKeywordParameters(nodeName)["settings"])>
    ']
    '<}> 
    <if(children!=[]){>,
    '   \"children\":
    '[<rvn_print(children)>
    ']
    '<}> 
    '}";


// TABS 
// Replacing a Tab with a Node2D, because in Godot 4 you do not have a standalone
// Tab Component anymore. Instead you fill in everything in a TabContainer and 
// children are seen as tabs. Name is the default.
str rvn_print(RavenNode nodeName:ravenTab(str nodeID, str name, list[RavenNode] children)) =
 "\"HBoxContainer\":
    '{
    '   \"id\": \"<nodeID>\",
    '   \"name\": \"<name>\"<if(children!=[]){>,
    '   \"children\":
    '[<rvn_print(children)>
    ']
    '<}> 
    '}";

// OPTION BUTTON
str rvn_print(RavenNode nodeName:ravenOptionButton(list[str] options, str callback)) =
 "\"OptionButton\":
    '{
    '   \"id\": \"<uuidi()>\",
    '   \"callback\": \"<callback>\"
    <if(options!=[]){>,
    '   \"options\":
    '[<rvn_print(options)>
    ']
    '<}> 
    '<if(isKeywordArgDefined(nodeName, "settings")){>,
    \"styles\": [
    '<rvn_print(getKeywordParameters(nodeName)["settings"])>
    ']
    '<}> 
    '}";

// https://docs.godotengine.org/en/stable/classes/class_panelcontainer.html#class-panelcontainer
str rvn_print(RavenNode nodeName:ravenPanelContainer(list[RavenNode] children)) =
 "\"PanelContainer\":
    '{
    '   \"id\": \"<uuidi()>\"
    '<if(isKeywordArgDefined(nodeName, "settings")){>,
    \"styles\": [
    '<rvn_print(getKeywordParameters(nodeName)["settings"])>
    ']
    '<}> 
    <if(children!=[]){>,
    '   \"children\":
    '[<rvn_print(children)>
    ']
    '<}> 
    '}";

// PANEL

str rvn_print(RavenNode nodeName:ravenPanel(list[RavenNode] children)) =
 "\"Panel\":
    '{
    '   \"id\": \"<uuidi()>\"
    '<if(isKeywordArgDefined(nodeName, "settings")){>,
    \"styles\": [
    '<rvn_print(getKeywordParameters(nodeName)["settings"])>
    ']
    '<}> 
    <if(children!=[]){>,
    '   \"children\":
    '[<rvn_print(children)>
    ']
    '<}> 
    '}";


// https://docs.godotengine.org/en/stable/classes/class_scrollcontainer.html#class-scrollcontainer
str rvn_print(RavenNode nodeName:ravenScrollContainer(list[RavenNode] children)) =
 "\"ScrollContainer\":
    '{
    '   \"id\": \"<uuidi()>\"
    '<if(isKeywordArgDefined(nodeName, "settings")){>,
    \"styles\": [
    '<rvn_print(getKeywordParameters(nodeName)["settings"])>
    ']
    '<}> 
    <if(children!=[]){>,
    '   \"children\":
    '[<rvn_print(children)>
    ']
    '<}> 
    '}";

default str rvn_print(RavenNode ravenNode) { throw "you forgot a case <typeOf(ravenNode)>"; } 


// MISC Functions
RavenNode mapNodesToJSON(RavenNode tree)  {
    println(tree);
    top-down-break visit(tree){
    case RavenNode tree : JSON_CONTENT += rvn_print(tree);
}

return tree;
}


public void genJSON(RavenNode tree) {
    mapNodesToJSON(tree);
    writeFile(JSON_TREE_FILE, JSON_CONTENT_START + JSON_CONTENT + JSON_CONTENT_END);
    JSON_CONTENT = "";
}

