
PROGRAM _INIT
	enableX := FALSE;
	enableY := FALSE;
	enableZ := FALSE;
	
	count:= 0;
	counter := 0;
	
END_PROGRAM

PROGRAM _CYCLIC 
	IF A_KILL_SWITCH THEN // Killswitch to stop robot in case of emergency
		ROBOSTATE := STOP;
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
		
		STOP:
			enableX := TRUE;
			enableY := TRUE;
			enableZ := TRUE;
			
		MOVE_1: // Move to given coordinates
			xPos := x1;
			yPos := y1;
			
			MoveX := COORD_TO_STEP(xPos, scale) - COORD_TO_STEP(xPosPrev, scale);
			MoveY := COORD_TO_STEP(yPos, scale) - COORD_TO_STEP(yPosPrev, scale);
			xPosPrev := x1;
			yPosPrev := y1;
			xPos := x2;
			yPos := y2;
	
		MOVE_2:	// Move to given coordinates
			MoveX := COORD_TO_STEP(xPos, scale) - COORD_TO_STEP(xPosPrev, scale);
			MoveY := COORD_TO_STEP(yPos, scale) - COORD_TO_STEP(yPosPrev, scale);
			xPosPrev := x2;
			yPosPrev := y2;
			
		MOVE0: // Move to origin (No code yet)
			
		BLYANTSPIDSER: // Pencil code 
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
		
		
			// State for when robot is drawing or not
		DRAW:
			WHILE NOT stopB DO
				directionZ := TRUE;
				stepZ := NOT stepZ;
			END_WHILE;
			
			// State for when robot isn't drawing and moves to next drawable position
		NOT_DRAW:
			WHILE NOT stopZ DO
				directionZ := FALSE;
				stepZ := NOT stepZ;
			END_WHILE;

	END_CASE;
END_PROGRAM

PROGRAM _EXIT
	 
END_PROGRAM

