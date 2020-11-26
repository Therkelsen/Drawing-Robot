
PROGRAM _INIT
	tcpst := TCPSTATE_SOCKET_OPEN;
	
	data1 := '';
	data2 := '';
	activeData := 2;
	readyForData := TRUE;
	firstData := TRUE;
	receivedData := FALSE;
	moreData := FALSE;
END_PROGRAM



PROGRAM _CYCLIC
	CASE tcpst OF
		TCPSTATE_SOCKET_OPEN :
			TcpOpen1.enable := TRUE;
			TcpOpen1.port := 12345;
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
			IF (readyForData) THEN
				TcpReceive1.enable := TRUE;
				TcpReceive1.ident := TcpServer1.identclnt;
				TcpReceive1.pData := ADR(receiveData);
				TcpReceive1.datamax := SIZEOF(receiveData);
				TcpReceive1();
				IF (TcpReceive1.status = ERR_OK) THEN
					tcpst := TCPSTATE_SEND;
					// Select right data buffer
					IF (activeData = 1) THEN
						data2 := '';
						data2 := LEFT(receiveData, UDINT_TO_INT(TcpReceive1.recvlen));
					ELSE
						data1 := '';
						data1 := LEFT(receiveData, UDINT_TO_INT(TcpReceive1.recvlen));
					END_IF
						
					// Important: set variables that is changed by higher priority tasks
					//            before the control variable
					readyForData := FALSE;
					receivedData := TRUE;
				END_IF
			END_IF

		(*TCPSTATE_SEND :
			sendData := 'OK';
			TcpSend1.enable := TRUE;
			TcpSend1.ident := TcpServer1.identclnt;
			TcpSend1.pData := ADR(sendData);
			TcpSend1.datalen := brsstrlen(ADR(sendData));     // We use brsstrlen() to get the length in UDINT datatype
			TcpSend1();
			IF (TcpSend1.status = ERR_OK) THEN
				tcpst := TCPSTATE_CLOSE;
			END_IF

		TCPSTATE_CLOSE :
			TcpClose1.enable := TRUE;
			TcpClose1.ident := TcpServer1.identclnt;
			TcpClose1();
			IF (TcpClose1.status = ERR_OK) THEN
				TcpServer1.enable := FALSE;
				TcpServer1();
				tcpst := TCPSTATE_SERVER_CREATE;
			END_IF*)
			
	END_CASE
	
	timer(IN := NOT timer.Q, PT := T#15000ms);
	
	
	IF (receivedData) THEN
		readyForData := FALSE;
		receivedData := FALSE;
		moreData := TRUE;
		
		IF (firstData) THEN
			firstData := FALSE;
			readyForData := TRUE;
			IF (activeData = 2) THEN
				activeData := 1;
			ELSE
				activeData := 2;
			END_IF
		END_IF;
	END_IF;
	
	IF (timer.Q) THEN
		IF (moreData) THEN
			moreData := FALSE;
			
			IF (activeData = 2) THEN
				activeData := 1;
			ELSE
				activeData := 2;
			END_IF
		ELSE
			firstData := TRUE;
		END_IF
		
		readyForData := TRUE;
	END_IF
			
END_PROGRAM




PROGRAM _EXIT
	TcpClose1.enable := TRUE;
	TcpClose1.ident := TcpServer1.identclnt;
	TcpClose1();

	TcpClose2.enable := TRUE;
	TcpClose2.ident := TcpOpen1.ident;
	TcpClose2();
	 
END_PROGRAM

