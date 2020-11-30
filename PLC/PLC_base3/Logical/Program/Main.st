
PROGRAM _INIT
	ROBOSTATE := READY;
	
	counter := 0;
	delim1 := ' ';
	delim2 := ',';
	
	Xenable := FALSE;
	Yenable := FALSE;
	Zenable := FALSE;
	
	count := 0;
	Programsteps := 1;
	StopMaskine := FALSE;
	XCounter := 0;
	YCounter := 0;
	ZCounter := 0;
	XCalib := 17680;
	YCalib := 13364;
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
END_PROGRAM

PROGRAM _CYCLIC 
	IF A_KILL_SWITCH THEN // Killswitch to stop robot in case of emergency
		//ROBOSTATE := STOP;
	END_IF;
	
	CASE ROBOSTATE OF 
		READY: // Does nothing, is meant to wait until finished receiving instructions
			IF (readyToConvert = TRUE) THEN
				ROBOSTATE := CONVERT;
			END_IF
			
		CONVERT:
			timer(IN := NOT timer.Q, PT := T#1000ms);
			IF (timer.Q = TRUE) THEN
				IF (counter < (instSize + 1)) THEN
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
					xArray[counter] := STRING_TO_INT(LEFT(string1, D1 - 1));
					yArray[counter] := STRING_TO_INT(MID(string1, D2 - D1 - 1, D1 + 1));
					zArray[counter] := STRING_TO_INT(MID(string1, D3 - D2 - 1, D2 + 1));
					
					xArray[counter + 1] := STRING_TO_INT(LEFT(string2, D4 - 1));
					yArray[counter + 1] := STRING_TO_INT(MID(string2, D5 - D4 - 1, D4 + 1));
					zArray[counter + 1] := STRING_TO_INT(MID(string2, D6 - D5 - 1, D5 + 1));
					counter := counter + 1;
				ELSE
					ROBOSTATE := DRAW;
				END_IF
			END_IF
			
		DRAW:
			IF (A_KILL_SWITCH <> TRUE) THEN
				IF (stopX <> TRUE) THEN
					IF (XPosMove = TRUE) THEN
						IF (XPosMove = XNegMove) THEN
							XPosMove := FALSE;
						END_IF
						Xdirection := FALSE;
						Xstep := NOT Xstep;
						XCounter := XCounter + 1;
					END_IF
				
					IF (XNegMove = TRUE) THEN
						IF (XPosMove = XNegMove) THEN
							XNegMove := FALSE;
						END_IF
						Xdirection := TRUE;
						Xstep := NOT Xstep;
						XCounter := XCounter - 1;
					END_IF
				END_IF
				
				IF (stopY <> TRUE) THEN
					IF (YPosMove = TRUE) THEN
						IF (YPosMove = YNegMove) THEN
							YPosMove := FALSE;
						END_IF
						Ydirection := FALSE;
						Ystep := NOT Ystep;
						YCounter := YCounter + 1;
					END_IF
				
					IF (YNegMove = TRUE) THEN
						IF (YPosMove = YNegMove) THEN
							YNegMove := FALSE;
						END_IF
						Ydirection := TRUE;
						Ystep := NOT Ystep;
						YCounter := YCounter - 1;
					END_IF
				END_IF
				
				IF (stopZ <> TRUE) THEN
					IF (ZPosMove = TRUE) THEN
						IF (ZPosMove = ZNegMove) THEN
							ZPosMove := FALSE;
						END_IF
						Zdirection := TRUE;
						Zstep := NOT Zstep;
						ZCounter := ZCounter + 1;
					END_IF
				
					IF (ZNegMove = TRUE) THEN
						IF (ZPosMove = ZNegMove) THEN
							ZNegMove := FALSE;
						END_IF
						Zdirection := FALSE;
						Zstep := NOT Xstep;
						ZCounter := XCounter - 1;
					END_IF
					count := count + 1;
				END_IF
			
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
			
			(*IF (A_KILL_SWITCH <> TRUE) THEN
				IF (XPosMove = TRUE) THEN
					IF (stopX <> TRUE) THEN
						IF (XPosMove = XNegMove) THEN
							XPosMove := FALSE;
						END_IF
						Xdirection := FALSE;
						Xstep := NOT Xstep;
						XCounter := XCounter + 1;
					END_IF
				END_IF
				
				IF (XNegMove = TRUE) THEN
					IF (stopX <> TRUE) THEN
						IF (XPosMove = XNegMove) THEN
							XNegMove := FALSE;
						END_IF
						Xdirection := TRUE;
						Xstep := NOT Xstep;
						XCounter := XCounter - 1;
					END_IF
				END_IF
				
				IF (YPosMove = TRUE) THEN
					IF (stopY <> TRUE) THEN
						IF (YPosMove = YNegMove) THEN
							YNegMove := FALSE;
						END_IF
						Ydirection := FALSE;
						Ystep := NOT Ystep;
						YCounter := YCounter + 1;
					END_IF
				END_IF
				
				IF (YNegMove = TRUE) THEN
					IF (stopY <> TRUE) THEN
						IF (YPosMove = YNegMove) THEN
							YNegMove := TRUE;
						END_IF
						Ydirection := TRUE;
						Ystep := NOT Ystep;
						YCounter := YCounter - 1;
					END_IF
				END_IF
				
				IF (ZPosMove = TRUE) THEN
					IF (stopZ <> TRUE) THEN
						IF (ZPosMove = ZNegMove) THEN
							ZNegMove := TRUE;
						END_IF
						Zdirection := TRUE;
						Zstep := NOT Zstep;
						ZCounter := ZCounter + 1;
					END_IF
				END_IF
				
				IF (ZNegMove = TRUE) THEN
					IF (stopZ <> TRUE) THEN
						IF (ZPosMove = ZNegMove) THEN
							ZNegMove := TRUE;
						END_IF
						Zdirection := FALSE;
						Zstep := NOT Zstep;
						ZCounter := ZCounter - 1;
					END_IF
				END_IF*)
			END_IF
		
		RESET: // ASSUMES XCALIB AND YCALIB AS CONTAINING MAX STEPS ON X AND Y AXIS AS IT USES THESE TO FIND ORIGO
			IF (A_KILL_SWITCH <> TRUE) THEN
				IF (stopX <> TRUE) THEN
					Xdirection := FALSE;
					Xstep := NOT Xstep;
					XCounter := XCounter + 1;
				ELSE
					XCounter := XCalib;
				END_IF
				IF (stopY <> TRUE) THEN
					Ydirection := FALSE;
					Ystep := NOT Ystep;
					YCounter := YCounter + 1;
				ELSE
					YCounter := YCalib;
				END_IF
				IF (stopZ <> TRUE) THEN
					Zdirection := FALSE;
					Zstep := NOT Zstep;
					ZCounter := ZCounter - 1;
				END_IF
			END_IF
			
		CALIBRATE: // ONLY USE CALIBRATE IF ALL STOP SENSORS ARE ACTIVATED
			IF (XCounter > 0) THEN
				Xdirection := TRUE;
				Xstep := NOT Xstep;
				XCounter := XCounter - 1;
			END_IF
			IF (YCounter > 0) THEN
				Ydirection := TRUE;
				Ystep := NOT Ystep;
				YCounter := YCounter - 1;
			END_IF
			
	END_CASE
					
END_PROGRAM

PROGRAM _EXIT
	 
END_PROGRAM