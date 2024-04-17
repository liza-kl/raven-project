module Interpreter::RavenNodes

import IO;
import ApplicationConf;
import String;
import Main;
import List;
import Type;


public data RavenNode = 
            ravenNode2D(str nodeID, list[RavenNode] children)
            | ravenButton(str nodeID,str label)
            | ravenLabel(str nodeID, str text);
            


str node2DtoJSON(RavenNode nodeName:ravenNode2D(str nodeID, list[RavenNode] children)) = "
    id: <print(nodeID)>
    children: [
            {<for(RavenNode child <- children){>
            '<traverseTreeRecursively(child)><}>
            '}
        ]
    ";


    //return "\"node2D\": {\"id\": \"<nodeName.nodeID>\"}";


str labelToJSON(RavenNode nodeName:ravenLabel(str nodeID, str text)) {
    println("Im in the label to json func");
    return "\"label\": {\"id\": \"<nodeID>\", \"text\": \"<text>\"},";
}
str buttonToJSON(RavenNode nodeName:ravenButton(str nodeID, str buttonText)) {
        println("Im in the button to json func");

    return "\"button\": {\"id\": \"<nodeID>\", \"text\": \"<buttonText>\",";
}
void traverseTreeRecursively(RavenNode root) {  
    switch (root) {
    case ravenNode2D(_, children): {
        JSON_CONTENT += node2DtoJSON(root);
        if(size(children) > 1) {
            str childToAdd = "";
            JSON_CONTENT += "\"children:\"[";
            for(child <- children) {
                traverseTreeRecursively(child);
            }
            JSON_CONTENT += "]";
        } else {
        JSON_CONTENT += node2DtoJSON(root);}}
    case ravenLabel(_,_): JSON_CONTENT += labelToJSON(root);
    case ravenButton(_,_): JSON_CONTENT+= buttonToJSON(root);
    
    }

    writeFile(JSON_TREE_FILE, JSON_CONTENT);
}



// Rascal Tree -> JSON -> Feed into Java -> Create Custom Format to parse it better -> Create Scene in Godot 
// Passing JSON tree as argument in makefile?
// Partial functions and recursive connection, you can just use the cases and then recursively until
// you see the base case goes with children = [];
// String template in rascal 
// https://github.com/vrozen/Cascade/blob/main/TEL/src/lang/tel/Printer.rsc
