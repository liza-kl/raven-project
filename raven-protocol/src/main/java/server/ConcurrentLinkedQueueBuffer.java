package server;

import java.util.concurrent.ConcurrentLinkedQueue;

public class ConcurrentLinkedQueueBuffer implements Buffer {
    private final ConcurrentLinkedQueue<String> queue = new ConcurrentLinkedQueue<>();

    public ConcurrentLinkedQueueBuffer() {
    }

    public void produce(String message) throws InterruptedException {
        synchronized(this.queue) {
            this.queue.add(message);
            this.queue.notifyAll();
        }
    }

    public String consume() throws InterruptedException {
        synchronized(this.queue) {
            while(this.queue.isEmpty()) {
                this.queue.wait();
            }
            return this.queue.poll();
        }
    }
}
