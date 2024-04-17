package cwi.masterthesis.raven.files;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class FileParser {

    public static List<String> parseFile(String filePath) {
        List<String> elements = new ArrayList<>();

        try (BufferedReader br = new BufferedReader(new FileReader(filePath))) {
            String line;
            StringBuilder currentElement = new StringBuilder();

            while ((line = br.readLine()) != null) {
                for (char c : line.toCharArray()) {
                    if (c == ';') {
                        elements.add(currentElement.toString().trim());
                        currentElement = new StringBuilder(); // Reset currentElement
                    } else {
                        currentElement.append(c);
                    }
                }
            }

            // Add the last element if it's not empty
            if (currentElement.length() > 0) {
                elements.add(currentElement.toString().trim());
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        return elements;
    }

    public static List<String> parsedElements(String filePath) {
        return parseFile(filePath);
    }



    public static void main(String[] args) {
        String filePath = "protocol.txt"; // Replace with your file path
        List<String> elements = parseFile(filePath);

        // Print the elements
        for (String element : elements) {
            System.out.println(element);
        }
    }
}
