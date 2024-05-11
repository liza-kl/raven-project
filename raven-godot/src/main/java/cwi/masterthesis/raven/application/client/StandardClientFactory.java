package cwi.masterthesis.raven.application.client;

import java.util.Objects;

public class StandardClientFactory implements ClientFactory  {
    @Override
    public Client createClientFromType(String clientType) {
        // TODO: Refactor with Enum / Switch Expression
        if (Objects.equals(clientType, "godot")) {
            return new GodotClient("0.0.0.0", 23000);
        }
//        if (Objects.equals(clientType, "native")) {
//            return new NativeClient("0.0.0.0", 23000,);
//        }
        throw new IllegalArgumentException("Unknown client type: " + clientType);
    }
}
