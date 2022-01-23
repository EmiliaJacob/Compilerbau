	loadc	0	
	dup		
	storer	0	
	loadc	2	
	call	RAM_UP	
	loadc	1	
	loadr	0	# adr var ASSIGN x: sym 0|0
	loadc	2	
	sub		
	stores		
1001	nop		
	loadr	0	# adr var ID x: sym 0|0
	loadc	2	
	sub		
	loads		
	loadc	10	
	cmple		
	jumpz	1000	
	loadr	0	
	call	1	# CALL square
	loadr	0	# adr var ID squ: sym 0|1
	loadc	2	
	sub		
	loadc	1	
	sub		
	loads		
	write		
	loadr	0	# adr var ID x: sym 0|0
	loadc	2	
	sub		
	loads		
	loadc	1	
	add		
	loadr	0	# adr var ASSIGN x: sym 0|0
	loadc	2	
	sub		
	stores		
	jump	1001	
1000	nop		
	call	RAM_DOWN	
	return		


1	nop		# square
	loadc	0	
	call	RAM_UP	
	loadr	0	# adr var ID x: sym 1|0
	loads		
	loadc	2	
	sub		
	loads		
	loadr	0	# adr var ID x: sym 1|0
	loads		
	loadc	2	
	sub		
	loads		
	mult		
	loadr	0	# adr var ASSIGN squ: sym 1|1
	loads		
	loadc	2	
	sub		
	loadc	1	
	sub		
	stores		
	call	RAM_DOWN	
	return		

RAM_UP	loadr	0	
	add		
	loadc	2	
	add		
	dup		
	loadc	1	
	sub		
	loadr	0	
	swap		
	stores		
	dup		
	storer	0	
	stores		
	return		

RAM_DOWN	loadr	0	
	loadc	1	
	sub		
	loads		
	storer	0	
	return		

