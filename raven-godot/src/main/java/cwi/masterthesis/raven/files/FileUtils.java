package cwi.masterthesis.raven.files;
import java.io.*;
import java.util.Scanner;

public class FileUtils {
    private static final String PROTOCOL_FILE = "protocol.txt";

    public static void createAProtocolFile() {
        try {
            java.io.File file = new java.io.File("./" + PROTOCOL_FILE);
            if (file.createNewFile()) {
                System.out.println("Created Protocol File: " + file.getAbsolutePath());
            } else {
                System.out.println("File already exists.");
            }
        } catch (IOException e) {
            System.out.println("An signalError occurred while creating the file: " + e.getMessage());
            return;
        }
    }
    public static void deleteFileContent() {
        System.out.println("Deleting Content");
        try
        {
            new PrintWriter(PROTOCOL_FILE).close();
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
    }
    public String readFromFile() {
        try {
            File myObj = new File(PROTOCOL_FILE);
            Scanner myReader = new Scanner(myObj);
            while (myReader.hasNextLine()) {
                String data = myReader.nextLine();
                System.out.println(data);
                return data;
            }
            myReader.close();
        } catch (FileNotFoundException e) {

            System.out.println("An signalError occurred.");

            e.printStackTrace();
        }
        return null;
    }

    public static void writeToFile(String contentToWrite) {

        try {
            FileWriter myWriter = new FileWriter("/Users/ekletsko/raven-project/raven-godot/protocol.txt");
            myWriter.write(contentToWrite);
            myWriter.close();

            System.out.println("Successfully wrote to the file.");

        } catch (IOException e) {
            System.out.println("An signalError occurred.");
            e.printStackTrace();
        }
    }


}
