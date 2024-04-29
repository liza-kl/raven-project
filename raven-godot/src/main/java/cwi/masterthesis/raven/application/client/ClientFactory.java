package cwi.masterthesis.raven.application.client;

public interface ClientFactory {
    public Client createClientFromType(String clientType);
}

