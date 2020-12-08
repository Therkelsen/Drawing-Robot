
PROGRAM _INIT
	Xenable := FALSE;	 
	Yenable := FALSE;
	Zenable := FALSE;
	Programsteps := 1;
	XCounter := 0;
	YCounter := 0;
	ZCounter := 0;
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
(*
			IF (StopMaskine = FALSE) THEN
				IF (Ydirection = TRUE) THEN
					Ystep := NOT Ystep;
					YCounter := YCounter+1;
				END_IF
				IF (Zdirection = TRUE) THEN
					Zstep := NOT Zstep;
					ZCounter := ZCounter+1;
				END_IF
			
				IF (Xdirection = TRUE) THEN
					Xstep := NOT Xstep;
					XCounter := XCounter + 1;
				END_IF
			END_IF
	*)
	
	IF (StopMaskine = FALSE) THEN
		IF (YNegMove = TRUE) THEN
			Ystep := NOT Ystep;
			YCounter := YCounter - 1;
		END_IF
		IF (YPosMove = TRUE) THEN
			Ystep := NOT Ystep;
			ZCounter := ZCounte + 1;
		END_IF
			
		IF (XNegMove = TRUE) THEN
			Xstep := NOT Xstep;
			XCounter := XCounter - 1;
	
		IF (XPosMove = TRUE) THEN
				Xstep := NOT Xstep;
				YCounter := YCounter + 1;
			END_IF
			IF (ZNegMove = TRUE) THEN
				Zstep := NOT Zstep;
				ZCounter := ZCounter - 1;
			END_IF
			
			IF (ZPosMove = TRUE) THEN
				Zstep := NOT Zstep;
				XCounter := XCounter + 1;
		END_IF
	END_IF
	*)
	
	(*
	IF (skalSpidses = TRUE AND XNegMove > 0 AND YNegMove > 0) THEN
			DO (XNegMove := TRUE AND YNegMove := TRUE) 
			ENDDO <(XCounter = 0 AND YCounter = 0)> ;
	*)
	
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM