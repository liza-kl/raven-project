module Server::Server


import IO;
import Exception;
import Server::ServerConfiguration;

@javaClass{cwi.masterthesis.raven.server.ServerUtils}
public java void startServer(int port);
@javaClass{cwi.masterthesis.raven.server.ServerUtils}
public java void stopServer();


// Test the Socket Server side on local ip and testport
void  testServer() {
	println("Starting Server");
	try {
		startServer(TEST_PORT);
		println("Server has been started");

	} catch RuntimeException re:  {
		println(re);
	}
//	stopServer();
}