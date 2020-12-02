
PROGRAM _INIT
	tcpst := TCPSTATE_SOCKET_OPEN;
	
	data1 := '';
	data2 := '';
	activeData := 2;
	readyForData := TRUE;
	firstData := TRUE;
	receivedData := FALSE;
	moreData := FALSE;
	receiveData := '';
	FOR count := 0 TO 999 DO
		instructionsArray[count] := '';
		xArray[count] := 0;		
		yArray[count] := 0;
		zArray[count] := 0;
	END_FOR;
	count := 0;
	readyToConvert := FALSE;
END_PROGRAM

PROGRAM _CYCLIC
	CASE tcpst OF
		TCPSTATE_SOCKET_OPEN: // Open socket for connection
			TcpOpen1.enable := TRUE;
			TcpOpen1.port := 12345;
			TcpOpen1.options := tcpOPT_REUSEADDR;
			TcpOpen1();
			IF (TcpOpen1.status = ERR_OK) THEN
				tcpst := TCPSTATE_SERVER_CREATE;
			END_IF
			
		TCPSTATE_SERVER_CREATE: // Connect to Java side
			TcpServer1.enable := TRUE;
			TcpServer1.ident := TcpOpen1.ident;
			TcpServer1();
			IF (TcpServer1.status = ERR_OK) THEN
				tcpst := TCPSTATE_RECEIVE;
			END_IF

		TCPSTATE_RECEIVE: // Prepare to receive data
			IF (readyForData) THEN
				TcpReceive1.enable := TRUE;
				TcpReceive1.ident := TcpServer1.identclnt;
				TcpReceive1.pData := ADR(receiveData);
				TcpReceive1.datamax := SIZEOF(receiveData);
				TcpReceive1();
				IF (TcpReceive1.status = ERR_OK) THEN
					tcpst := TCPSTATE_RECEIVE;
					// Select right data buffer and store coordinates in instructionsArray[]
					IF (activeData = 1) THEN
						data2 := '';
						data2 := LEFT(receiveData, UDINT_TO_INT(TcpReceive1.recvlen));
						IF (data2 <> 'DONE') THEN
							instructionsArray[count] := data2;
						ELSE
							instSize := count;
							readyToConvert := TRUE;
						END_IF
					ELSE
						data1 := '';
						data1 := LEFT(receiveData, UDINT_TO_INT(TcpReceive1.recvlen));
						IF (data1 <> 'DONE') THEN
							instructionsArray[count] := data1;
						ELSE
							instSize := count;
							readyToConvert := TRUE;
						END_IF
						
					END_IF
						
					// Important: set variables that is changed by higher priority tasks
					// before the control variable
					readyForData := FALSE;
					receivedData := TRUE;
					count := count + 1;
				END_IF
			END_IF
			IF (TcpSend1.status = ERR_OK) THEN
				tcpst := TCPSTATE_RECEIVE;
			END_IF

		TCPSTATE_SEND: // Send OK back to Java side, to signal successful receiving of data
			sendData := 'OK';
			TcpSend1.enable := TRUE;
			TcpSend1.ident := TcpServer1.identclnt;
			TcpSend1.pData := ADR(sendData);
			TcpSend1.datalen := brsstrlen(ADR(sendData)); // Uses brsstrlen() to get the length in UDINT datatype
			TcpSend1();
			IF (TcpSend1.status = ERR_OK) THEN
				tcpst := TCPSTATE_RECEIVE;
			END_IF

		TCPSTATE_CLOSE: // Close TCP socket and reset data variables
			TcpClose1.enable := TRUE;
			TcpClose1.ident := TcpServer1.identclnt;
			TcpClose1();
			
			data1 := '';
			data2 := '';
			activeData := 2;
			readyForData := TRUE;
			firstData := TRUE;
			receivedData := FALSE;
			moreData := FALSE;
			receiveData := '';
			FOR count := 0 TO 249 DO
				instructionsArray[count] := '';
			END_FOR;
			count := 0;
			
			IF (TcpClose1.status = ERR_OK) THEN
				TcpServer1.enable := FALSE;
				TcpServer1();
				tcpst := TCPSTATE_SERVER_CREATE;
			END_IF
		
		TCPSTATE_RESET:	// Reset data variables
			data1 := '';
			data2 := '';
			activeData := 2;
			readyForData := TRUE;
			firstData := TRUE;
			receivedData := FALSE;
			moreData := FALSE;
			receiveData := '';
			FOR count := 0 TO 999 DO
				instructionsArray[count] := '';
				xArray[count] := 0;		
				yArray[count] := 0;
				zArray[count] := 0;
			END_FOR;
			count := 0;
			tcpst := TCPSTATE_RECEIVE;
	END_CASE
	
	
	// Double buffer part of code
	timer(IN := NOT timer.Q, PT := T#100ms);
	
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

