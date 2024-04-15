module Client::Client

import IO;
extend Client::ClientConfiguration;
import Server::ServerConfiguration;

@javaClass{cwi.masterthesis.raven.client.ClientUtils}
public java int startClient(str ip, int port);
@javaClass{cwi.masterthesis.raven.client.ClientUtils}
public java str sendMessage(str msg);
@javaClass{cwi.masterthesis.raven.client.ClientUtils}
public java void stopClient();

// Test the Socket Client on the test port (ServerController) by sending Ping
void testClient() {
	startClient(LOCALHOST, TEST_PORT);
	println(sendMessage("ping"));
	stopClient();
}