
TYPE
	movestate : 
		(
		stop,
		move0,
		blyantspidser
		);
	COMMSTATE : 
		(
		isconnected,
		executing,
		recieving,
		offline
		);
	TCPSTATE : 
		(
		TCPSTATE_SERVER_CREATE,
		TCPSTATE_RECEIVE,
		TCPSTATE_SEND,
		TCPSTATE_SOCKET_CLOSE,
		TCPSTATE_SOCKET_OPEN
		);
END_TYPE
