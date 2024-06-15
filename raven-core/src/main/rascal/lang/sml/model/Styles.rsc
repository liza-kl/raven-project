module lang::sml::model::Styles
import lang::raven::RavenNode;

public list[Setting] textEditSettings = [setting("Vector2", [setting("custom_minimum_size",  [
        <"x",200>,
        <"y",30>
      ])])];

public list[Setting] buttonDanger = [setting("StyleBoxFlat", [setting("normal",  [
        <"bg_color","LINEN">
      ])])];

public list[Setting] runtimeTabelLabel = [setting("FontSize", [<"font_size", 50>])];