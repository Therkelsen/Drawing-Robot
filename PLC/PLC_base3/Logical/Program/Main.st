
PROGRAM _INIT
	enableX := FALSE;
	enableY := FALSE;
	enableZ := FALSE;
	mainstring := '';
	
	stateGUI := 0;
	
count:= 0;
	
END_PROGRAM

PROGRAM _CYCLIC 
	IF A_KILL_SWITCH THEN			//Hvis noget g�r galt kan �verste variabel, denne, s�ttes TRUE/1 og motorerne sl�r fra.
	  ROBOSTATE := STOP;
	END_IF;
	
	(*CASE COMMSTATE OF
		CONNECTED:
		RECEIVING:
		
		OFFLINE:
		  

	END_CASE;*)
	
	//stateGUI
	IF stateGUI = 0 THEN
		ROBOSTATE := IDLE;
	ELSIF stateGUI = 1 THEN
		ROBOSTATE := DRAW;
	ELSIF stateGUI = 2 THEN
		ROBOSTATE := NOT_DRAW;
		
	END_IF;
	
	
	CASE tcpstate OF										//Socket communications
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
				tcpstate := TCPSTATE_SOCKET_CLOSE;
				sendData := '';
				sendData := LEFT(receiveData, UDINT_TO_INT(tcpReceive1.recvlen));
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
		
	END_CASE;		//Socket communications end
	
	
	CASE ROBOSTATE OF	//Movement
		IDLE:
			IF count <> 0 THEN
				count := 0;
			END_IF;
				
		
		RECEIVE:
		timer2(IN := NOT timer2.Q, PT := T#15000ms);
	
	
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
		
		CONVERT:
			delim1 := ' ';
			delim2 := ',';
	
			//deler maintring i 2 strings med x og y i hver
			string1 := LEFT(mainstring, FIND(mainstring, delim2));
			string2 := RIGHT(mainstring, FIND(mainstring, delim2));
			
			//finder positioner af delimiters " " og "," i hver ny string
			D1 := FIND(string1, delim1);
			D2 := FIND(string1, delim2);
			D3 := FIND(string2, delim1);
			D4 := FIND(string2, delim2);
			
	
			x1string := LEFT(string1, D1 - 1);
			y1string := MID(string1, D2 - D1 - 1, D1 + 1);
			
			x2string := LEFT(string2, D3 - 1);
			y2string := MID(string2, D4 - D3 - 1, D3 + 1);
	
			//isolerer x og y koordinat i hver ny string
			x1 := STRING_TO_INT(x1string);
			y1 := STRING_TO_INT(y1string);
	
			x2 := STRING_TO_INT(x2string);
			y2 := STRING_TO_INT(y2string);
		
		STOP:
			enableX := TRUE;
			enableY := TRUE;
			enableZ := TRUE;
			
		MOVE_1:
			//bev�g sig efter x og y-koordinaterne
			xPos := x1;
			yPos := y1;
			
			MoveX := COORD_TO_STEP(xPos, scale) - COORD_TO_STEP(xPosPrev, scale);
			MoveY := COORD_TO_STEP(yPos, scale) - COORD_TO_STEP(yPosPrev, scale);
			xPosPrev := x1;
			yPosPrev := y1;
			xPos := x2;
			yPos := y2;
	
		MOVE_2:
			
			MoveX := COORD_TO_STEP(xPos, scale) - COORD_TO_STEP(xPosPrev, scale);
			MoveY := COORD_TO_STEP(yPos, scale) - COORD_TO_STEP(yPosPrev, scale);
			xPosPrev := x2;
			yPosPrev := y2;
			
		MOVE0:
			
			//bev�g sig til udgangsposition / origo
			
			
			//Primitiv blyantspidser-sekvens fra en af de f�rste dage jeg k�rte med robottens motorer
		BLYANTSPIDSER:
			IF   start1 = TRUE THEN
		
		IF stopZ = FALSE AND stopX = FALSE THEN
			directionZ := FALSE;
	  		stepZ := NOT stepZ;
		END_IF;
		
		IF stopX = FALSE AND stopZ = TRUE THEN
			IF stepX = FALSE THEN
				stepX := TRUE;
			ELSIF 
				stepX = TRUE THEN
				stepX := FALSE;
				
			END_IF;
	    	stepX := NOT stepX;
		END_IF;
	
		IF stopB = FALSE AND stopX = TRUE THEN
			directionZ := TRUE;
			stepZ := NOT stepZ;
		END_IF;
	
		timer.IN := NOT timer.Q;
		timer.PT := T#5s;
		timer(); 
		bspidser := timer.Q;

		IF stopZ = FALSE THEN
			directionZ := FALSE;
			stepZ := NOT stepZ;
		END_IF;
		  
	END_IF;
		
		
			//state for hvorn�r blyanten er nede p� papiret og der alts� tegnes. Lettere priimitivt
		DRAW:
			count := 0;
			IF NOT stopB THEN
				directionZ := TRUE;
				stepZ := NOT stepZ;
			END_IF;
			
			//state for vorn�r blyanten er l�ftet fra papiret og den bev�ger sig til n�ste koordinat hvor der skal tegnes
			//Lettere primitivt.
		NOT_DRAW:
			IF  count < 600 THEN
				count := count + 1;
				directionZ := FALSE;
	  			stepZ := NOT stepZ;
			END_IF;
			IF count = 600 OR count > 600 THEN
				ROBOSTATE := IDLE;
			END_IF;
		

	END_CASE;

	
(*	IF start1 = TRUE THEN			//test til at k�re fra ene side til anden p� x-aksen og beregne l�ngden fra pixel til praksis
	  
		IF stopX = FALSE THEN
			stepX := NOT stepX;
			count := count + 1;
		END_IF
	
		IF stopX = TRUE THEN
	  		start1 := FALSE;
		END_IF;	
		
	END_IF;		*)					//slut
	
	
	   
END_PROGRAM

PROGRAM _EXIT
	tcpClose1.enable := TRUE;
	tcpClose1.ident := tcpServer1.identclnt;
	tcpClose1();

	tcpClose2.enable := TRUE;
	tcpClose2.ident := tcpOpen1.ident;
	tcpClose2();
	 
END_PROGRAM
