
PROGRAM _INIT
	enable1 := FALSE;
	enable2 := FALSE;
	enable3 := FALSE;
	
count:= 0;
	
END_PROGRAM

PROGRAM _CYCLIC 
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
		  
	
		//mynikkr
		
		
		
		 
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
	(* Insert code here *)
	 
END_PROGRAM

