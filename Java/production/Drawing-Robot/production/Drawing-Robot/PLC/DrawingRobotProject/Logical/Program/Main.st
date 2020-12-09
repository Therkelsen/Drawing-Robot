
PROGRAM _INIT
	ROBOSTATE := READY;
	
	counter := 0;
	delim1 := ' ';
	delim2 := ',';
	
	xEnable := FALSE;
	yEnable := FALSE;
	zEnable := FALSE;
	
	count := 0;
	xCounter := 0;
	yCounter := 0;
	zCounter := 0;
	xCalib := 0; //17680
	yCalib := 0; //13364
	zCalib := 0;
	yPrev := 0;
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
	hasBeenSharpened := FALSE;
	scale := 25; // steps / px
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
	
			xEnable := FALSE;
			yEnable := FALSE;
			zEnable := FALSE;
	
			count := 0;
			xCounter := 0;
			yCounter := 0;
			zCounter := 0;
			xCalib := 0; //17680
			yCalib := 0; //13364
			zCalib := 0;
			yPrev := 0;
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
			readyToConvert := FALSE;
			scale := 25;
			
			FOR count := 0 TO 999 DO
				instructionsArray[count] := '';
				xArray[count] := 0;
				yArray[count] := 0;
				zArray[count] := 0;
			END_FOR;
			
			ROBOSTATE := READY;
			
		READY: // Does nothing, is meant to wait until finished receiving instructions
			IF (readyToConvert = TRUE) THEN
				ROBOSTATE := CONVERT;
			END_IF
			
		CONVERT:
			timer(IN := NOT timer.Q, PT := T#100ms);
			IF (timer.Q = TRUE) THEN
				IF (count < (instSize)) THEN
					// Splits element on index counter of instructionsArray[] into two seperate strings
					string1 := LEFT(instructionsArray[count], (LEN(instructionsArray[count]) - FIND(instructionsArray[count], delim2)));
					string2 := RIGHT(instructionsArray[count], (LEN(instructionsArray[count]) - FIND(instructionsArray[count], delim2)));
					
					// Finds numerical positions of all delimiters " " and "," in both strings
					// Isolates coordinates into individual integers
					D1 := FIND(string1, delim1);
					xString[counter] := LEFT(string1, D1 - 1);
					xArray[counter] := STRING_TO_INT(xString[counter]);
					string1 := DELETE(string1, D1, 1);
					
					D2 := FIND(string1, delim1);
					yString[counter] := LEFT(string1, D2 - 1);
					yArray[counter] := STRING_TO_INT(yString[counter]);
					string1 := DELETE(string1, D2, 1);
					
					D3 := FIND(string1, delim2);
					zString[counter] := LEFT(string1, D3 - 1);
					zArray[counter] := STRING_TO_INT(zString[counter]);
					string1 := DELETE(string1, D3, 1);
					
					counter := counter + 1;
					
					D4 := FIND(string2, delim1);
					xString[counter] := LEFT(string2, D4 - 1);
					xArray[counter] := STRING_TO_INT(xString[counter]);
					string2 := DELETE(string2, D4, 1);
					
					D5 := FIND(string2, delim1);
					yString[counter] := LEFT(string2, D5 - 1);
					yArray[counter] := STRING_TO_INT(yString[counter]);
					string2 := DELETE(string2, D5, 1);
					
					D6 := FIND(string2, delim2);
					zString[counter] := LEFT(string2, D6 - 1);
					zArray[counter] := STRING_TO_INT(zString[counter]);
					string2 := DELETE(string2, D6, 1);
					
					counter := counter + 1;
					count := count + 1;
					
				ELSE
					counter := 0;
					count := 0;
					ROBOSTATE := RESET;
				END_IF	
			END_IF
		RESET: // ASSUMES XCALIB AND YCALIB AS CONTAINING MAX STEPS ON X AND Y AXIS AS IT USES THESE TO FIND ORIGO
			sharpener := FALSE;
			IF (killswitch <> TRUE) THEN
				zCalib := 0;
				IF (zStop <> TRUE) THEN
					zDirection := FALSE;
					zStep := NOT zStep;
					zCounter := zCounter + 1;
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
				
				IF (xStop = TRUE AND yStop = TRUE AND zStop = TRUE) THEN
					ROBOSTATE := CALIBRATE;
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
				IF (bStop <> TRUE AND zPosMove = FALSE) THEN
					zDirection := TRUE;
					zStep := NOT zStep;
					zCounter := zCounter + 1;
				ELSIF (bStop = TRUE AND zPosMove = FALSE) THEN
					zPosMove := TRUE;
					zCounter := 0;
				ELSIF (zPosMove = TRUE) THEN
					IF (zCounter < 500) THEN
						zDirection := FALSE;
						zStep := NOT zStep;
						zCounter := zCounter + 1;
					ELSE
						zPosMove := FALSE;
						xCounter := 0;
						yCounter := 0;
						ROBOSTATE := DRAW;
					END_IF
				END_IF
			END_IF
		
		DRAW:
			IF (killswitch <> TRUE) THEN
				IF (counter < (instSize * 2)) THEN
					IF (xStop <> TRUE) THEN
						IF (xArray[counter] * scale > xCounter) THEN
							xNext := FALSE;
							xDirection := TRUE;
							xStep := NOT xStep;
							xCounter := xCounter + 1;
						ELSIF (xArray[counter] * scale < xCounter) THEN
							xNext := FALSE;
							xDirection := FALSE;
							xStep := NOT xStep;
							xCounter := xCounter - 1; 
						ELSIF (xArray[counter] * scale = xCounter) THEN
							ROBOSTATE := PENCILDOWN;
						END_IF
					END_IF
				ELSE 
					ROBOSTATE := STOP;
				END_IF	
			END_IF
			
		PENCILDOWN: 
			IF (killswitch <> TRUE) THEN
				IF (bStop <> TRUE) THEN
					zDirection := TRUE;
					zStep := NOT zStep;
					zCounter := zCounter - 1;
				ELSE
					counter := counter + 1;
					zCounter := 0;
					ROBOSTATE := DRAW2;
				END_IF			
			END_IF
			
		DRAW2:
			IF (killswitch <> TRUE) THEN
				IF (xStop <> TRUE) THEN
					IF (xArray[counter] * scale > xCounter) THEN
						xDirection := TRUE;
						xStep := NOT xStep;
						xCounter := xCounter + 1;
					ELSIF (xArray[counter] * scale < xCounter) THEN
						xDirection := FALSE;
						xStep := NOT xStep;
						xCounter := xCounter - 1; 
					ELSIF (xArray[counter] * scale = xCounter) THEN
						ROBOSTATE := PENCILUP;
					END_IF
				END_IF
			END_IF
			
		PENCILUP: 
			IF (killswitch <> TRUE) THEN
				IF (zCounter < 300) THEN
					zDirection := FALSE;
					zStep := NOT zStep;
					zCounter := zCounter + 1;
				ELSIF (zCounter = 300 OR zStop = TRUE) THEN
					counter := counter + 1;
					ROBOSTATE := CHECKLINE;
				END_IF
			END_IF
		
		CHECKLINE:
			IF (killswitch <> TRUE) THEN
				IF (yArray[counter + 2] = yArray[counter]) THEN
					IF (hasBeenSharpened = FALSE) AND (counter MOD(100) = 0) THEN
						ROBOSTATE := DRAW;
					ELSE
						ROBOSTATE := DRAW;
					END_IF
				ELSE
					ROBOSTATE := NEXTLINE;
				END_IF
			END_IF
			
		NEXTLINE:
			IF (killswitch <> TRUE) THEN
				IF (yStop <> TRUE) THEN
					IF (yCounter = (yArray[counter + 1] * scale)) THEN
						ROBOSTATE := DRAW;
					ELSIF (yCounter < (yArray[counter + 1] * scale)) THEN
						yDirection := TRUE;
						yStep := NOT yStep;
						yCounter := yCounter + 1;
					END_IF
				END_IF
			END_IF
			
		
		SHARPEN:
			IF (killswitch <> TRUE) THEN
				IF ((zCounter < 3700) AND (zStop <> TRUE) AND (xStop <> TRUE)) THEN
					zDirection := FALSE;
					zStep := NOT zStep;
					zCounter := zCounter + 1;
				ELSIF ((zCounter >= 3700) AND (xStop <> TRUE) AND (zStop <> TRUE)) THEN
					xDirection := FALSE;
					xStep := NOT xStep;
					xCounter := xCounter - 1;
				ELSIF ((xStop = TRUE) AND (zStop <> TRUE)) THEN
					IF ((hasBeenSharpened <> TRUE) AND (zCounter > 1650)) THEN
						sharpener := TRUE;
						zDirection := TRUE;
						zStep := NOT zStep;
						zCounter := zCounter - 1;
					ELSIF (zCounter = 1650) THEN
						timer(IN := NOT timer.Q, PT := T#2500ms);
						hasBeenSharpened := TRUE;
					END_IF
					IF ((zCounter < 3700) AND (hasBeenSharpened = TRUE) AND (timer.Q)) THEN
						sharpener := FALSE;
						zDirection := FALSE;
						zStep := NOT zStep;
						zCounter := zCounter + 1;
					ELSIF ((zCounter >= 3700) AND (hasBeenSharpened = TRUE)) THEN
						ROBOSTATE := BACK;
					END_IF
				END_IF
			END_IF
			
		BACK:
			IF (killswitch <> TRUE) THEN
				IF ((xArray[counter] * scale > xCounter) AND (hasBeenSharpened = TRUE)) THEN
					xDirection := TRUE;
					xStep := NOT xStep;
					xCounter := xCounter + 1;
				ELSIF ((xArray[counter] * scale = xCounter) AND (bStop <> TRUE) AND (hasBeenSharpened = TRUE)) THEN
					zDirection := TRUE;
					zStep := NOT zStep;
					zCounter := zCounter - 1;
				ELSIF ((xArray[counter] * scale = xCounter) AND (bStop = TRUE) AND (hasBeenSharpened = TRUE)) THEN
					ROBOSTATE := DRAW;
				END_IF
			END_IF
		
		STOP:
			IF (killswitch <> TRUE) THEN
				IF (zCounter < 500) THEN
					zDirection := FALSE;
					zStep := NOT zStep;
					zCounter := zCounter + 1;
				ELSIF (zCounter = 500) THEN
				END_IF
			END_IF
		
	END_CASE
END_PROGRAM

PROGRAM _EXIT
	 
END_PROGRAM