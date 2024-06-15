package server;

public interface Buffer {
    public void produce(String message) throws InterruptedException;
    public String consume() throws InterruptedException;
}
