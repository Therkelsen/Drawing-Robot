PROGRAM _INIT
	tcpst := TCPSTATE_SOCKET_OPEN;
END_PROGRAM



PROGRAM _CYCLIC
	CASE tcpst OF
		TCPSTATE_SOCKET_OPEN :
			TcpOpen1.enable := TRUE;
			TcpOpen1.port := 80;
			TcpOpen1.options := tcpOPT_REUSEADDR;
			TcpOpen1();
			IF (TcpOpen1.status = ERR_OK) THEN
				tcpst := TCPSTATE_SERVER_CREATE;
			END_IF
			
		TCPSTATE_SERVER_CREATE :
			TcpServer1.enable := TRUE;
			TcpServer1.ident := TcpOpen1.ident;
			TcpServer1();
			IF (TcpServer1.status = ERR_OK) THEN
				tcpst := TCPSTATE_RECEIVE;
			END_IF

		TCPSTATE_RECEIVE :
			TcpReceive1.enable := TRUE;
			TcpReceive1.ident := TcpServer1.identclnt;
			TcpReceive1.pData := ADR(receiveData);
			TcpReceive1.datamax := SIZEOF(receiveData);
			TcpReceive1();
			IF (TcpReceive1.status = ERR_OK) THEN
				tcpst := TCPSTATE_CLOSE;
				sendData := receiveData;
			END_IF

		(*TCPSTATE_SEND :
			TcpSend1.enable := TRUE;
			TcpSend1.ident := TcpServer1.identclnt;
			TcpSend1.pData := ADR(sendData);
			TcpSend1.datalen := brsstrlen(ADR(sendData));     // We use brsstrlen() to get the length in UDINT datatype
			TcpSend1();
			IF (TcpSend1.status = ERR_OK) THEN
				tcpst := TCPSTATE_CLOSE;
			END_IF*)

		TCPSTATE_CLOSE :
			TcpClose1.enable := TRUE;
			TcpClose1.ident := TcpServer1.identclnt;
			TcpClose1();
			IF (TcpClose1.status = ERR_OK) THEN
				TcpServer1.enable := TRUE;
				TcpServer1();
				tcpst := TCPSTATE_SERVER_CREATE;
			END_IF
			
	END_CASE
			
END_PROGRAM