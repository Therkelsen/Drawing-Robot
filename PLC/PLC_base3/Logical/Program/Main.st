
PROGRAM _INIT
	Xenable := FALSE;
	Yenable := FALSE;
	Zenable := FALSE;
	
	Programsteps := 1;
	StopMaskine := FALSE;
	XCounter := 0;
	YCounter := 0;
	ZCounter := 0;
	XCalib := 0;
	YCalib := 0;
	ZCalib := 0;
	Xdirection := FALSE;
	Ydirection := FALSE;
	Zdirection := FALSE;
	Xstep := FALSE;
	Ystep := FALSE;
	Zstep := FALSE;
	XNegMove := FALSE;
	YNegMove := FALSE;
	ZNegMove := FALSE;
	XPosMove := FALSE;
	YPosMove := FALSE;
	ZPosMove := FALSE;
	
	count:= 0;
	counter := 0;
	
END_PROGRAM

PROGRAM _CYCLIC 
	IF A_KILL_SWITCH THEN // Killswitch to stop robot in case of emergency
		//ROBOSTATE := STOP;
	END_IF;
	
	CASE ROBOSTATE OF 
		CONVERT:
			delim1 := ' ';
			delim2 := ',';
			
			// Splits element on index counter of instructionsArray[] into two seperate strings
			string1 := LEFT(instructionsArray[counter], FIND(instructionsArray[counter], delim2));
			string2 := RIGHT(instructionsArray[counter], FIND(instructionsArray[counter], delim2));
			
			// Finds numerical positions of all delimiters " " and "," in both strings
			D1 := FIND(string1, delim1);
			D2 := FIND(string1, delim1) + D1;
			D3 := FIND(string1, delim2);
			D4 := FIND(string2, delim1);
			D5 := FIND(string2, delim1) + D4;
			D6 := FIND(string2, delim2);
			
			// Isolates coordinates into individual integers
			x1 := STRING_TO_INT(LEFT(string1, D1 - 1));
			y1 := STRING_TO_INT(MID(string1, D2 - D1 - 1, D1 + 1));
			z1 := STRING_TO_INT(MID(string1, D3 - D2 - 1, D2 + 1));
			
			x2 := STRING_TO_INT(LEFT(string2, D4 - 1));
			y2 := STRING_TO_INT(MID(string2, D5 - D4 - 1, D4 + 1));
			z2 := STRING_TO_INT(MID(string2, D6 - D5 - 1, D5 + 1));
			
		DRAW:
			(*IF XPosMove = TRUE THEN
				XNegMove := FALSE;
				Xdirection := FALSE;
			ELSE
				XNegMove := TRUE;
				Xdirection := TRUE;
			END_IF
				
			IF YPosMove = TRUE THEN
				YNegMove := FALSE;
				Ydirection := FALSE;
			ELSE
				YNegMove := TRUE;
				Ydirection := TRUE;
			END_IF
				
			IF YPosMove = TRUE THEN
				YNegMove := FALSE;
				Ydirection := FALSE;
			ELSE
				YNegMove := TRUE;
				Ydirection := TRUE;
			END_IF
			
			IF A_KILL_SWITCH <> TRUE THEN
				IF XPosMove = TRUE THEN
					Xstep := NOT Xstep;
				END_IF
				IF XPosMove = FALSE THEN
					//Xstep := NOT Xstep;
				END_IF
				IF YPosMove = TRUE THEN
					Ystep := NOT Ystep;
				END_IF
				IF YPosMove = FALSE THEN
					//Ystep := NOT Ystep;
				END_IF
				IF ZPosMove = TRUE THEN
					Zstep := NOT Zstep;
				END_IF
				IF ZPosMove = FALSE THEN
					//Zstep := NOT Zstep;
				END_IF
			END_IF
			
			IF A_KILL_SWITCH <> TRUE THEN
				Xstep := NOT Xstep;
			END_IF*)
			
			(*Xenable := FALSE;
			Yenable := FALSE;
			Zenable := FALSE;*)
			
			IF (A_KILL_SWITCH <> TRUE) THEN
				IF (XPosMove = TRUE) THEN
					IF (XPosMove = XNegMove) THEN
						XPosMove := FALSE;
					END_IF
					Xdirection := FALSE;
					Xstep := NOT Xstep;
					IF (stopX <> TRUE) THEN
						XCounter := XCounter + 1;
					END_IF
				END_IF
				
				IF (XNegMove = TRUE) THEN
					IF (XPosMove = XNegMove) THEN
						XNegMove := FALSE;
					END_IF
					Xdirection := TRUE;
					Xstep := NOT Xstep;
					IF (stopX <> TRUE) THEN
						XCounter := XCounter - 1;
					END_IF
				END_IF
				
				IF (YPosMove = TRUE) THEN
					Ydirection := FALSE;
					Ystep := NOT Ystep;
					IF (stopY <> TRUE) THEN
						YCounter := YCounter + 1;
					END_IF
				END_IF
				
				IF (YNegMove = TRUE) THEN
					Ydirection := TRUE;
					Ystep := NOT Ystep;
					IF (stopY <> TRUE) THEN
						YCounter := YCounter + 1;
					END_IF
				END_IF
				
				IF (ZPosMove = TRUE) THEN
					Zdirection := TRUE;
					Zstep := NOT Zstep;
					IF (stopZ <> TRUE) THEN
						ZCounter := ZCounter + 1;
					END_IF
				END_IF
				
				IF (ZNegMove = TRUE) THEN
					Zdirection := FALSE;
					Zstep := NOT Zstep;
					IF (stopZ <> TRUE) THEN
						ZCounter := ZCounter + 1;
					END_IF
				END_IF
			END_IF
		
		RESET:
			Xdirection := FALSE;
			Ydirection := FALSE;
			Zdirection := FALSE;
			IF (A_KILL_SWITCH <> TRUE) THEN
				IF (stopX <> TRUE) THEN
					Xstep := NOT Xstep;
					XCounter := XCounter + 1;
				END_IF
				IF (stopY <> TRUE) THEN
					Ystep := NOT Ystep;
					YCounter := YCounter + 1;
				END_IF
				IF (stopZ <> TRUE) THEN
					Zstep := NOT Zstep;
					ZCounter := ZCounter - 1;
				END_IF
				ZCounter := 0;
			END_IF
			
		CALIBRATE:
			Xdirection := FALSE;
			Ydirection := FALSE;
			IF (A_KILL_SWITCH <> TRUE) THEN
				IF (stopX <> TRUE) THEN
					Xstep := NOT Xstep;
					XCalib := XCalib + 1;
				ELSE
					XCounter := XCalib;
				END_IF
				IF (stopY <> TRUE) THEN
					Ystep := NOT Ystep;
					YCalib := YCalib + 1;
				ELSE
					YCounter := YCalib;
				END_IF
			END_IF
			
	END_CASE
					
END_PROGRAM

PROGRAM _EXIT
	 
END_PROGRAM