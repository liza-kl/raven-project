module lang::raven::helpers::Server

/** 
* A module for calling functions from the raven-protocol package in this project
* Mainly to allow the user to start and stop the server from Rascal side and put
* Rascal in charge.
**/

@javaClass{server.Server}
public java void send(str message);

