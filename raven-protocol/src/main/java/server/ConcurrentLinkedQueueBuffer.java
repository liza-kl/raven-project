package server;

import java.util.concurrent.ConcurrentLinkedQueue;

public class ConcurrentLinkedQueueBuffer implements Buffer {
    private final ConcurrentLinkedQueue<String> queue = new ConcurrentLinkedQueue<String>();

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
