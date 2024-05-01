package server;

import java.util.concurrent.ConcurrentLinkedQueue;

public class Buffer {
    private final ConcurrentLinkedQueue<String> queue = new ConcurrentLinkedQueue<String>();
    private static Buffer instance = null;

    public static synchronized Buffer getInstance() {
        if (instance == null) {
            instance = new Buffer();
        }
        return instance;
    }

    public void produce(String message) throws InterruptedException {
        synchronized (queue) {
            queue.add(message);
            queue.notifyAll();
        }
    }


    public String consume() throws InterruptedException {
        synchronized(queue) {
            while (queue.isEmpty()) {
                queue.wait();
            }
            return queue.poll();
        }
    }

}
