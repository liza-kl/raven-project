module lang::sml::model::Styles
import lang::raven::RavenNode;

public list[Setting] textEditSettings = [setting("Vector2", [setting("custom_minimum_size",  [
        <"x",200>,
        <"y",30>
      ])])];

public list[Setting] buttonDanger = [
    setting("Color", [<"font_color", "GHOST_WHITE">]),
    setting("StyleBoxFlat", [setting("normal",  [
        <"bg_color","INDIAN_RED">,
        <"height", 30>,
        <"width", 50>

      ])])];


public list[Setting] runtimeTabelLabel = [setting("FontSize", [<"font_size", 50>])];

public list[Setting] ravenPanelStyle =[setting("StyleBoxFlat",
                                        [setting(
                                            "panel",
                                            [<"bg_color", "LAVENDER">]
                                        )])]; 

/* Table Editor */
public list[Setting] tableEditorHeadings = [setting("FontSize", [<"font_size", 30>])];
