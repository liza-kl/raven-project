package cwi.masterthesis.raven.interpreter.mapper.stylingstrategy;

import godot.core.Color;
import godot.core.StringNameUtils;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Objects;

import static cwi.masterthesis.raven.Main.mainTheme;


public class ColorStrategy implements StylingStrategy {

    private final String nameOfNode;
    private final String themingKey;
    private Color color;

    public static Color getColorByName(String colorName) {
        try {
            String formattedColorName = formatColorName(colorName);
            Class<?> companionClass = Color.Companion.class;
            Method method = companionClass.getMethod("get" + formattedColorName);

            return (Color) method.invoke(Color.Companion);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * @param colorName A valid constant from Godot Color Constants. E.g. LAVENDER_BLUSH
     * @return The adjusted name for Color getter. E.g. getLavenderBlush()
     */
    private static String formatColorName(String colorName) {
        String[] parts = colorName.split("_");
        StringBuilder formattedName = new StringBuilder();

        for (String part : parts) {
            formattedName.append(part.charAt(0)).append(part.substring(1).toLowerCase());
        }

        return formattedName.toString();
    }

    /**
     * @param nameOfNode The Window / Control Node class you want to style. E.g. Button
     * @param themingKey The property you want to change. e.g. font_color
     * @param color The color you want to set. Either a numbers array of RGBA values or Name Constants from
     *              https://docs.godotengine.org/en/stable/classes/class_color.html#constants
     */
    public ColorStrategy(String nameOfNode, String themingKey, Object color) {
        this.nameOfNode = nameOfNode;
        this.themingKey = themingKey;

        if (color instanceof ArrayList) {
            ArrayList<Float> colorList = (ArrayList<Float>) color;

            if (colorList.size() == 4) {
                float r =  (float) colorList.get(0);
                float g = (float) colorList.get(1);
                float b =  (float)colorList.get(2);
                float a = (float) colorList.get(3);
                this.color = new Color(r,g,b,a);
        }
        }
        if (color instanceof String) {
            this.color = new Color(Objects.requireNonNull(getColorByName((String) color)));
        }
        else {
            throw new IllegalArgumentException("Color must be either an ArrayList or a String");
        }
    }

    /**
     * Is going to call the equivalent in Godot: theme.setColor()
     * https://docs.godotengine.org/en/stable/classes/class_theme.html#class-theme-method-set-color
     */
    @Override
    public void applyStyling() {
        mainTheme.setColor(StringNameUtils.asStringName(this.themingKey),
                    StringNameUtils.asStringName(this.nameOfNode), this.color);
    }
}
