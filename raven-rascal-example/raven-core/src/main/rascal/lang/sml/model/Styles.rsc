module lang::sml::model::Styles
import lang::raven::RavenNode;

// Font Size

public list[Setting] h1FontSize = [
setting("FontSize", [<"font_size", 30>])
];

public list[Setting] h2FontSize = [
setting("FontSize", [<"font_size", 25>])
];

public list[Setting] bodyFontSize = [
setting("FontSize", [<"font_size", 20>])
];


public list[Setting] textEditSettings = bodyFontSize + [setting("Vector2", [setting("custom_minimum_size",  [
        <"x",200>,
        <"y",30>
      ])])];


// OptionButton
public list[Setting] optionButtonSettings = bodyFontSize;



public list[Setting] primaryButton = bodyFontSize + [
   setting("StyleBoxFlat", [setting("normal",  [
        <"bg_color","HONEYDEW">
      ])]) 
];

public list[Setting] buttonCreate = bodyFontSize + [
  setting("Color", [<"font_color", "DARK_SLATE_GRAY">]),
  setting("StyleBoxFlat", [setting("normal",  [
        <"bg_color","HONEYDEW">
      ])]) 
];


public list[Setting] tabContainerStyles = bodyFontSize + [
  setting("SizeFlags", [<"size_flags_horizontal","SIZE_EXPAND_FILL">,
                        <"size_flags_vertical", "SIZE_EXPAND_FILL">
                        ]),
                
  setting("AnchorPreset", [<"set_anchors_preset", "PRESET_FULL_RECT">])
];

public list[Setting] tabContentStyles = [
    setting("SizeFlags", [<"size_flags_horizontal","SIZE_EXPAND_FILL">,
                        <"size_flags_vertical", "SIZE_EXPAND_FILL">
                        ]),
                
  setting("AnchorPreset", [<"set_anchors_preset", "PRESET_FULL_RECT">]) 
];

public list[Setting] hboxContainerStyles = [
  setting("SizeFlags", [<"size_flags_horizontal","SIZE_EXPAND_FILL">,
                        <"size_flags_vertical", "SIZE_EXPAND_FILL">
                        ]),
                
  setting("AnchorPreset", [<"set_anchors_preset", "PRESET_FULL_RECT">])
];

public list[Setting] hboxContainerHorizontalExpand = [
  setting("SizeFlags", [<"size_flags_horizontal","SIZE_EXPAND_FILL">
                        ]),
                
  setting("AnchorPreset", [<"set_anchors_preset", "PRESET_FULL_RECT">])
];




public list[Setting] panelStyles = [
  setting("SizeFlags", [<"size_flags_horizontal","SIZE_EXPAND_FILL">,
                        <"size_flags_vertical", "SIZE_EXPAND_FILL">
                        ]),
                
  setting("AnchorPreset", [<"set_anchors_preset", "PRESET_FULL_RECT">])
];

public list[Setting] panelTreeEditor = panelStyles + [
  setting("StyleBoxFlat", [setting("panel",  [
        <"bg_color","LIGHT_CORAL">,
        <"border_width_top", "Long%10">,
        <"border_width_bottom", "Long%10">,
        <"border_blend", "Bool%true">
      ])]) 
];

public list[Setting] vboxContainerStyles = [
  setting("SizeFlags", [<"size_flags_horizontal","SIZE_EXPAND_FILL">,
                        <"size_flags_vertical", "SIZE_EXPAND_FILL">
                        ]),
                
  setting("AnchorPreset", [<"set_anchors_preset", "PRESET_FULL_RECT">])
];

public list[Setting] vboxContainerSizeFill = [
  setting("SizeFlags", [<"size_flags_horizontal","SIZE_FILL">,
                        <"size_flags_vertical", "SIZE_FILL">
                        ]),
                
  setting("AnchorPreset", [<"set_anchors_preset", "PRESET_FULL_RECT">])
];
public list[Setting] scrollContainerStyles = [
setting("SizeFlags", [<"size_flags_horizontal","SIZE_FILL_EXPAND">,
                        <"size_flags_vertical", "SIZE_FILL_EXPAND">
                        ]),
  setting("Primitive", [<"clip_contents", "Bool%false">]),
                
  setting("AnchorPreset", [<"set_anchors_preset", "PRESET_FULL_RECT">])
];
public list[Setting] buttonSubmit = bodyFontSize +  [

  setting("Color", [<"font_color", "DARK_SLATE_GRAY">]),
  setting("StyleBoxFlat", [setting("normal",  [
        <"bg_color","GHOST_WHITE">,
        <"height", 30>,
        <"width", 50>
      ])]) 
];

public list[Setting] buttonDanger = bodyFontSize +  [
    setting("Color", [<"font_color", "GHOST_WHITE">]),
    setting("StyleBoxFlat", [setting("normal",  [
        <"bg_color","INDIAN_RED">,
        <"height", 30>,
        <"width", 50>

      ])])];


public list[Setting] runtimeTabelLabel = [setting("FontSize", [<"font_size", 30>])];

public list[Setting] ravenPanelStyle =[setting("StyleBoxFlat",
                                        [setting(
                                            "panel",
                                            [<"bg_color", "LAVENDER">,
                                            <"content_margin_left","Float%5.0">] 
                                        )])]; 

/* Table Editor */
public list[Setting] tableEditorHeadings = [setting("FontSize", [<"font_size", 30>])];
