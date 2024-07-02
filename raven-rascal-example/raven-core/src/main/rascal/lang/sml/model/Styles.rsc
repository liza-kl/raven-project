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


public list[Setting] tabContainerStyles = h2FontSize + [
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

public list[Setting] marginContainerSetting = [
  setting("Constant", [<"margin_top", 20>])
];

public list[Setting] marginContainer5 = [
  setting("Constant", [<"margin_top", 5>,<"margin_bottom",5>])
];

public list[Setting] marginContainerEven = [
  setting("Constant",
    [<"margin_left", 5>,
    <"margin_right",5>,
    <"margin_top", 5>,
    <"margin_bottom", 5>])] + hboxContainerStyles;

public list[Setting] marginContainerTreeEditor = [
   setting("Constant",
    [<"margin_left", 30>
   ])];

public list[Setting] marginContainerTreeEditor2 = [
   setting("Constant",
    [<"margin_left", 60>
   ])];


public list[Setting] panelStyles = [
  setting("SizeFlags", [<"size_flags_horizontal","SIZE_EXPAND_FILL">,
                        <"size_flags_vertical", "SIZE_EXPAND_FILL">
                        ]),
                
  setting("AnchorPreset", [<"set_anchors_preset", "PRESET_FULL_RECT">])
];

public list[Setting] panelTreeEditor =   [
  setting("StyleBoxFlat", [setting("panel",  [
        <"bg_color","LIGHT_CORAL">
      ])]) 
];

public list[Setting] panelTreeEditorState = [
  setting("StyleBoxFlat", [setting("panel",  [
        <"bg_color","ORANGE">
      ])])
];

public list[Setting] panelTreeEditorEditState = [
 setting("StyleBoxFlat", [setting("panel",  [
        <"bg_color","DARK_VIOLET">
      ])])  
];

public list[Setting] panelTableEditor =   [
  setting("StyleBoxFlat", [setting("panel",  [
        <"bg_color","DEEP_PINK">
      ])]) 
];

public list[Setting] vboxContainerStyles = [
  setting("SizeFlags", [<"size_flags_horizontal","SIZE_EXPAND_FILL">,
                        <"size_flags_vertical", "SIZE_EXPAND_FILL">
                        ]),
                
  setting("AnchorPreset", [<"set_anchors_preset", "PRESET_FULL_RECT">])
];

public list[Setting] vBoxContainerCenter = [
  setting("SizeFlags", [<"size_flags_horizontal","SIZE_EXPAND_FILL">,
                        <"size_flags_vertical", "SIZE_SHRINK_CENTER">
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
        <"bg_color","GHOST_WHITE">
      ])]) 
];

public list[Setting] buttonDanger = bodyFontSize +  [
    setting("Color", [<"font_color", "GHOST_WHITE">]),
    setting("StyleBoxFlat", [setting("normal",  [
        <"bg_color","INDIAN_RED"> 
      ])])];

public list[Setting] buttonBlue = bodyFontSize +  [
    setting("Color", [<"font_color", "GHOST_WHITE">])
    ];


public list[Setting] runtimeTabelLabel = h2FontSize + setting("Color", [<"font_color","DARK_BLUE">]);

public list[Setting] tableHeadingStyle =   setting("SizeFlags", [<"size_flags_horizontal","SIZE_EXPAND_FILL">
                        ]) + [setting("Color", [<"font_color","GHOST_WHITE">]),
                                        setting("StyleBoxFlat",
                                        [setting(
                                            "panel",
                                            [
                                            <"bg_color","CORAL">] 
                                        )])]; 
public list[Setting] tableBodyStyle =   setting("SizeFlags", [<"size_flags_horizontal","SIZE_EXPAND_FILL">
                        ]) + [
                                        setting("StyleBoxFlat",
                                        [setting(
                                            "panel",
                                            [
                                            <"bg_color","GHOST_WHITE">] 
                                        )])]; 


public list[Setting] ravenPanelStyle = hboxContainerHorizontalExpand;

/* Table Editor */
public list[Setting] tableEditorHeadings = h2FontSize; 
