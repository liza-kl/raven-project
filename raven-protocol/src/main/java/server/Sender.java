package server;

import java.io.BufferedReader;
import java.io.IOException;

public class Sender implements Runnable {
    private final Buffer buffer;
    private final BufferedReader reader;

    public Sender(Buffer buffer, BufferedReader reader) {
        this.buffer = buffer;
        this.reader = reader;
    }

    @Override
    public void run() {
        try {
            String line;
            while ((line = reader.readLine()) != null) {
                synchronized (buffer) {
                    buffer.produce(line);
                }
            }
        } catch (InterruptedException e) {
            e.printStackTrace();
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

}
