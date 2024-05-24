package server;

public class Receiver implements Runnable {
    private final Buffer buffer;
    private final ReceiveCallback callback;

    public Receiver(Buffer buffer, ReceiveCallback callback) {
        this.buffer = buffer;
        this.callback = callback;
    }

    @Override
    public void run() {
        try {

            while (true) {
                String element = buffer.consume();
                callback.onReceive(element);}
        } catch (InterruptedException e) {
            throw new RuntimeException(e);
        }
    }
}