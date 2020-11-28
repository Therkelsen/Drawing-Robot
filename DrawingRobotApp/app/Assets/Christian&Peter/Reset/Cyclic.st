
PROGRAM _CYCLIC
	IF RunReset = TRUE THEN
	
	
	// Vi køre X-aksen i reset.
	
		IF Xsensor = FALSE THEN
			Xdirection := FALSE;
			Xstep := NOT Xstep;
			XCounter := XCounter+1;

		END_IF;	
	
	// Når X-aksen er i reset, køre vi Y-aksen i reset.
	
		IF Ysensor = FALSE AND Xsensor = TRUE THEN
			Ydirection := FALSE;
			Ystep := NOT Ystep;
		YCounter := YCounter+1;
		END_IF;
		// Vi køre Blyant op for at den ikke er i vejen på vej til reset.
		
		IF Zsensor = FALSE THEN
			Zdirection := FALSE;
			Zstep := NOT Zstep;
			ZCounter := ZCounter+1;
		END_IF;
	  
	
	
	END_IF;
END_PROGRAM
