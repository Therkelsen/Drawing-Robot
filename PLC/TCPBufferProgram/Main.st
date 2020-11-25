
PROGRAM _INIT
	(* Insert code here *)
	data1 := '';
	data2 := '';
	activeData := 2;
	readyForData := TRUE;
	firstData := TRUE;
	receivedData := FALSE;
	moreData := FALSE;
END_PROGRAM

PROGRAM _CYCLIC
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
	(* Insert code here *)
	 
END_PROGRAM

