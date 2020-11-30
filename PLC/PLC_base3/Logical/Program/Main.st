
PROGRAM _INIT
	ROBOSTATE := READY;
	
	counter := 0;
	delim1 := ' ';
	delim2 := ',';
	
	Xenable := FALSE;
	Yenable := FALSE;
	Zenable := FALSE;
	
	count := 0;
	xCounter := 0;
	yCounter := 0;
	zCounter := 0;
	xCalib := 0; //17680
	yCalib := 0; //13364
	zCalib := 0;
	xNext := FALSE;
	yNext := FALSE;
	zNext := FALSE;
	xDirection := FALSE;
	yDirection := FALSE;
	zDirection := FALSE;
	xStep := FALSE;
	yStep := FALSE;
	zStep := FALSE;
	xNegMove := FALSE;
	yNegMove := FALSE;
	zNegMove := FALSE;
	xPosMove := FALSE;
	yPosMove := FALSE;
	zPosMove := FALSE;
END_PROGRAM

PROGRAM _CYCLIC 
	IF killswitch THEN // Killswitch to stop robot in case of emergency
		//ROBOSTATE := STOP;
	END_IF;
	
	CASE ROBOSTATE OF 
		INIT:
			counter := 0;
			delim1 := ' ';
			delim2 := ',';
			
			Xenable := FALSE;
			Yenable := FALSE;
			Zenable := FALSE;
			
			count := 0;
			Programsteps := 1;
			StopMaskine := FALSE;
			xCounter := 0;
			yCounter := 0;
			zCounter := 0;
			xCalib := 0; //17680
			yCalib := 0; //13364
			zCalib := 0;
			xNext := FALSE;
			yNext := FALSE;
			zNext := FALSE;
			xDirection := FALSE;
			yDirection := FALSE;
			zDirection := FALSE;
			xStep := FALSE;
			yStep := FALSE;
			zStep := FALSE;
			xNegMove := FALSE;
			yNegMove := FALSE;
			zNegMove := FALSE;
			xPosMove := FALSE;
			yPosMove := FALSE;
			zPosMove := FALSE;
			
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
					
					xArray[counter + 3] := STRING_TO_INT(LEFT(string2, D4 - 1));
					yArray[counter + 3] := STRING_TO_INT(MID(string2, D5 - D4 - 1, D4 + 1));
					zArray[counter + 3] := STRING_TO_INT(MID(string2, D6 - D5 - 1, D5 + 1));
					counter := counter + 1;
				ELSE
					ROBOSTATE := DRAW;
					counter := 0;
				END_IF
			END_IF
			
		MANUAL:
			IF (killswitch <> TRUE) THEN
				IF (xStop <> TRUE OR xCounter > 0) THEN
					IF (xPosMove = TRUE) THEN
						IF (xPosMove = xNegMove) THEN
							xPosMove := FALSE;
						END_IF
						xDirection := FALSE;
						xStep := NOT xStep;
						xCounter := xCounter + 1;
					END_IF
				
					IF (xNegMove = TRUE) THEN
						IF (xPosMove = xNegMove) THEN
							xNegMove := FALSE;
						END_IF
						xDirection := TRUE;
						xStep := NOT xStep;
						xCounter := xCounter - 1;
					END_IF
				END_IF
				
				IF (yStop <> TRUE OR yCounter > 0) THEN
					IF (yPosMove = TRUE) THEN
						IF (yPosMove = yNegMove) THEN
							yPosMove := FALSE;
						END_IF
						yDirection := FALSE;
						yStep := NOT yStep;
						yCounter := yCounter + 1;
					END_IF
				
					IF (yNegMove = TRUE) THEN
						IF (yPosMove = yNegMove) THEN
							yNegMove := FALSE;
						END_IF
						yDirection := TRUE;
						yStep := NOT yStep;
						yCounter := yCounter - 1;
					END_IF
				END_IF
				
				IF (zCounter >= 0) THEN
					IF (zPosMove = TRUE) THEN
						IF (zPosMove = zNegMove) THEN
							zPosMove := FALSE;
						END_IF
						zDirection := TRUE;
						zStep := NOT zStep;
						zCounter := zCounter + 1;
					END_IF
				
					IF (zNegMove = TRUE) THEN
						IF (zPosMove = zNegMove) THEN
							zNegMove := FALSE;
						END_IF
						zDirection := FALSE;
						zStep := NOT zStep;
						zCounter := zCounter - 1;
					END_IF
				END_IF
			END_IF
		
		DRAW:
			IF (killswitch <> TRUE) THEN
				IF (xStop <> TRUE AND xNext <> TRUE) THEN
					IF (xCounter < xArray[counter]) THEN
						xDirection := TRUE;
						xStep := NOT xStep;
						xCounter := xCounter + 1;
					ELSIF (xCounter > xArray[counter]) THEN
						xDirection := FALSE;
						xStep := NOT xStep;
						xCounter := xCounter - 1;
					ELSE
						XNext := TRUE;
					END_IF
				END_IF
				
				IF (yStop <> TRUE AND yNext <> TRUE) THEN
					IF (yCounter < yArray[counter]) THEN
						yDirection := TRUE;
						yStep := NOT yStep;
						yCounter := yCounter + 1;
					ELSIF (yCounter > yArray[counter]) THEN
						yDirection := FALSE;
						yStep := NOT yStep;
						yCounter := yCounter - 1;
					ELSE
						XNext := TRUE;
					END_IF
				END_IF
			END_IF

		PENCIL: IF (killswitch <> TRUE) THEN
					IF (xCounter >= 3280 AND xCounter <= 17680 AND yCounter >= 1364 AND yCounter <= 13364) THEN
						IF (bStop <> TRUE AND zCounter < 0 AND zArray[counter] = TRUE) THEN
							zDirection := TRUE;
							zStep := NOT zStep;
							zCounter := zCounter - 1;
						ELSIF (bStop <> TRUE AND zCounter < 250 AND zArray[counter] = FALSE) THEN
							zDirection := FALSE;
							zStep := NOT zStep;
							zCounter := zCounter + 1;
						END_IF
					END_IF
				END_IF
			END_IF

		RESET: // ASSUMES XCALIB AND YCALIB AS CONTAINING MAX STEPS ON X AND Y AXIS AS IT USES THESE TO FIND ORIGO
			IF (killswitch <> TRUE) THEN
				zCalib := 0;
				IF (zStop <> TRUE) THEN
					zDirection := FALSE;
					zStep := NOT zStep;
					zCounter := zCounter - 1;
				ELSE
					zCounter := zCalib;
				END_IF
				IF (xStop <> TRUE AND zStop = TRUE) THEN
					xDirection := FALSE;
					xStep := NOT xStep;
					xCounter := xCounter + 1;
				ELSE
					xCounter := xCalib;
				END_IF
				IF (yStop <> TRUE AND zStop = TRUE) THEN
					yDirection := FALSE;
					yStep := NOT yStep;
					yCounter := yCounter + 1;
				ELSE
					yCounter := yCalib;
				END_IF
				
			END_IF
			
		CALIBRATE: // ONLY USE CALIBRATE IF ALL STOP SENSORS ARE ACTIVATED
			IF (xCounter < 3280) THEN
				xDirection := TRUE;
				xStep := NOT xStep;
				xCounter := xCounter + 1;
			END_IF
			IF (yCounter < 1364) THEN
				yDirection := TRUE;
				yStep := NOT yStep;
				yCounter := yCounter + 1;
			END_IF
			IF (xCounter >= 3280 AND xCounter <= 17680 AND yCounter >= 1364 AND yCounter <= 13364) THEN
				IF (stopB <> TRUE AND zPosMove = FALSE) THEN
					zDirection := TRUE;
					zStep := NOT zStep;
					zCounter := zCounter + 1;
				ELSIF (bStop = TRUE AND zPosMove = FALSE) THEN
					zPosMove = TRUE;
					zCounter = 0;
				ELSIF (zPosMove = TRUE) THEN
					IF (zCounter < 250) THEN
						zDirection := FALSE;
						zStep := NOT zStep;
						zCounter := zCounter + 1;
					ELSE
						zPosMove = FALSE
						ROBOSTATE = DRAW;
					END_IF
				END_IF
			END_IF
	END_CASE
END_PROGRAM

PROGRAM _EXIT
	 
END_PROGRAM