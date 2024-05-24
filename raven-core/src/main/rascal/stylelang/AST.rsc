module stylelang::AST

alias Color = str;
alias Constant = int;
alias Value = value;

data StyleNode = button() | label();

data PropertyType = color(Color c) | constant(Constant k);

data AST = empty()
    | style(StyleNode name, PropertyType propertyType, Value themeValue);
