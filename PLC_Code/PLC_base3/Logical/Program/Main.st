
PROGRAM _INIT
	enable1 := FALSE;
	enable2 := FALSE;
	enable3 := FALSE;
	
count:= 0;
	
END_PROGRAM

PROGRAM _CYCLIC 
	CASE commstate OF
		isconnected:
		recieving:
		executing:
		offline:
		  

	END_CASE;
	
	
	CASE tcpstate OF
		TCPSTATE_SOCKET_OPEN:
			tcpOpen1.enable := TRUE;
			tcpOpen1.port := 80;
			tcpOpen1.options := tcpOPT_REUSEADDR;
			tcpOpen1();
			IF (tcpOpen1.status = ERR_OK) THEN
				tcpstate := TCPSTATE_SERVER_CREATE;	  
			END_IF;
			
		TCPSTATE_SERVER_CREATE:
			tcpServer1.enable := TRUE;
			tcpServer1.ident := tcpOpen1.ident;
			tcpServer1();
			IF (tcpServer1.status = ERR_OK) THEN
				tcpstate := TCPSTATE_RECEIVE;
			END_IF
			
		TCPSTATE_RECEIVE:
			tcpReceive1.enable := TRUE;
			tcpReceive1.ident := tcpServer1.identclnt;
			tcpReceive1.pData := ADR(receiveData);
			tcpReceive1.datamax := SIZEOF(receiveData);
			tcpReceive1();
			IF (tcpReceive1.status = ERR_OK) THEN
				tcpstate := TCPSTATE_SEND;
				sendData := '';
				sendData := LEFT(receiveData, UDINT_TO_INT(tcpReceive1.recvlen));
			END_IF
			
		TCPSTATE_SEND:
			tcpSend1.enable := TRUE;
			tcpSend1.ident := tcpServer1.identclnt;
			tcpSend1.pData := ADR(sendData);
			tcpSend1.datalen := brsstrlen (ADR(sendData));     // We use brsstrlen() to get the length in UDINT datatype
			tcpSend1();
			IF (tcpSend1.status = ERR_OK) THEN
				tcpstate := TCPSTATE_SOCKET_CLOSE;
			END_IF
			
		TCPSTATE_SOCKET_CLOSE:
			tcpClose1.enable := TRUE;
			tcpClose1.ident := tcpServer1.identclnt;
			tcpClose1();
			IF (tcpClose1.status = ERR_OK) THEN
				tcpServer1.enable := FALSE;
				tcpServer1();
				tcpstate := TCPSTATE_SERVER_CREATE;
			END_IF

		
	END_CASE;
(*	IF   start1 = TRUE THEN
		
		IF stop3 = FALSE AND stop1 = FALSE THEN
			direction3 := FALSE;
	  		step3z := NOT step3z;
		END_IF;
		
		IF stop1 = FALSE AND stop3 = TRUE THEN
			(*IF step1x = FALSE THEN
				step1x := TRUE;
			ELSIF 
				step1x = TRUE THEN
				step1x := FALSE;
				
			END_IF;*)
	    (*	step1x := NOT step1x;
		END_IF;
	
		IF stopb = FALSE AND stop1 = TRUE THEN
			direction3 := TRUE;
			step3z := NOT step3z;
		END_IF;*)
(*		
		timer.IN := NOT timer.Q;
		timer.PT := T#5s;
		timer(); 
		bspidser := timer.Q;
(*
		IF stop3 = FALSE THEN
			direction3 := FALSE;
			step3z := NOT step3z;
		END_IF;
		  
		
		
		
		 
	END_IF;*)
	
	IF start1 = TRUE THEN
	  
		IF stop1 = FALSE THEN
			step1x := NOT step1x;
			count := count + 1;
		END_IF
	
		IF stop1 = TRUE THEN
	  		start1 := FALSE;
		END_IF;	
		
	END_IF;
	
	
	   
END_PROGRAM

PROGRAM _EXIT
	tcpClose1.enable := TRUE;
	tcpClose1.ident := tcpServer1.identclnt;
	tcpClose1();

	tcpClose2.enable := TRUE;
	tcpClose2.ident := tcpOpen1.ident;
	tcpClose2();
	 
END_PROGRAM

