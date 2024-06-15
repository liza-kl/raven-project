package cwi.masterthesis.raven.interpreter.mapper.stylingstrategy;

import godot.Control;
import godot.core.StringNameUtils;
import godot.core.Vector2;

/*
* TODO this is a class with a custom Godot type usually used for set a minimum size etc.
* In future this should be made more generic to not retype everything.
*/
public class Vector2OverrideStrategy implements StylingStrategy{

    private final Control node;
    private final String themingKey;
    private final Integer x;
    private final Integer y;

    public Vector2OverrideStrategy(Control node, String themingKey, Integer x, Integer y) {
        this.node = node;
        this.themingKey = themingKey;
        this.x = x;
        this.y = y;
    }

    @Override
    public void applyStyling() {
        node.set(StringNameUtils.asStringName(this.themingKey), new Vector2(x,y));
    }
}
