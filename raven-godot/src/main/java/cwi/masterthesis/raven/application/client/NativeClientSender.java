package cwi.masterthesis.raven.application.client;

import godot.global.GD;
import server.Buffer;

import java.io.BufferedReader;
import java.io.IOException;

public class NativeClientSender implements Runnable {
    private final Buffer buffer;
    private final BufferedReader reader;


    public NativeClientSender(Buffer buffer, BufferedReader reader) {
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
