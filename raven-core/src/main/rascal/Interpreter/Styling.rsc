module Interpreter::Styling
import List;
import IO;
import ApplicationConf;
public data StylingTuple = 
    strVal(str strKey, str strVal)
    | numVal(str intKey, int intVal)
    | colorVal(str colorKey, Color color);

data NodeType = button() | label();

data Color = fromString(str name) | fromRGB(num r, num g, num b) | fromRGBA(num r, num g, num b, num a);
alias Constant = int;
data PropertyType = color() | constant();
alias PropertySettings = tuple[PropertyType propType, list[StylingTuple] stylingTuple];
alias GeneralThemeElement = tuple[NodeType nodeType, list[PropertySettings] settings];
alias GeneralTheme = list[GeneralThemeElement];

/* PRINTING Color */
str style_print(Color color:fromString(str name)) = "\"<name>\"";
str style_print(Color color:fromRGB(num r, num g, num b)) = "[<r>,<g>,<b>]";
str style_print(Color color:fromRGBA(num r, num g, num b, num a)) = "[<r>,<g>,<b>, <a>]";
/* PRINTING Constant */
str style_print(Constant constant) = "<constant>";
/* PRINTING PropertyType */
str style_print(PropertyType propType:color()) = "\"Color\"";
str style_print(PropertyType propType:constant()) = "\"Constant\""; 


/* PRINTING NodeType */
str style_print(NodeType typ:button()) = "\"Button\"";
str style_print(NodeType typ:label()) = "\"Label\"";

/* PRINTING StylingTuple */

str style_print(StylingTuple style:strVal(_,_)) = 
    "\"<style.strKey>\": \"<style.strVal>\"";

str style_print(StylingTuple style:numVal(str intKey, int intVal)) = 
    "\"<intKey>\": <intVal>";

str style_print(StylingTuple style:colorVal(str colorKey, Color color)) = 
    "\"<colorKey>\": <style_print(color)>";

/* PRINTING List StylingTuple */
str style_print(list[StylingTuple] styles) = "

'<for(StylingTuple style <- styles){>
'   <style_print(style)><if(!(indexOf(styles,style) == size(styles) - 1)){>,
'<}>
<}>
";

/* PRINTING PropertySettings */
str style_print(PropertySettings settings) = "
'<style_print(settings.propType)>: 
'{<style_print(settings.stylingTuple)>
'}
";

/* PRINTING list[PropertySettings] */

str style_print(list[PropertySettings] settings) = "
'[<for(PropertySettings setting <- settings){>
'{
'   <style_print(setting)>}<if(!(indexOf(settings,setting) == size(settings) - 1)){>,
'<}>
<}>
']
";


/* PRINTING GeneralThemeElement */ 
str style_print(GeneralThemeElement elem) = "
'<style_print(elem.nodeType)>: 
'
'<style_print(elem.settings)>
'
";
/* PRINTING GeneralTheme */ 

str style_print(GeneralTheme themeElements) = "
'[<for(GeneralThemeElement theme <- themeElements){>
'{
'   <style_print(theme)>}<if(!(indexOf(themeElements,theme) == size(themeElements) - 1)){>,
'<}>
<}>
']
";


public void main() {
        GeneralTheme theme = [
                <button(),
                [
                        <color(),
                        [
                                colorVal("font_color", fromRGBA(127,212,230,0.2)),
                                colorVal("font_hover_color", fromRGBA(127,212,230,2))
                        ]>
                ]>,
                <label(),
                [
                        <color(),
                        [
                                colorVal("font_color", fromRGBA(127,123,230,0.2)),
                                colorVal("font_hover_color", fromRGBA(127,123,230,2))
                        ]>
                ]>
        ];
        println(style_print(theme));
        writeFile(JSON_STYLING_FILE,style_print(theme));
}

