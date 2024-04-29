package cwi.masterthesis.raven.application.client;

public interface Client {
    public void connect();
    public void disconnect();
    public boolean send(String message);
    public void virtualProcess();
    public void virtualReady();
}
