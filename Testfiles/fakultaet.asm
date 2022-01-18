	loadc	0	
	dup		
	storer	0	
	loadc	2	
	call	RAM_UP	
	read		
	loadr	0	# adr var READ n: sym 0|0
	loadc	2	
	sub		
	stores		
	loadc	1	
	loadr	0	# adr var ASSIGN f: sym 0|1
	loadc	2	
	sub		
	loadc	1	
	sub		
	stores		
	loadr	0	
	call	1	# CALL fak
	loadr	0	# adr var ID f: sym 0|1
	loadc	2	
	sub		
	loadc	1	
	sub		
	loads		
	write		
	call	RAM_DOWN	
	return		


1	nop		# fak
	loadc	0	
	call	RAM_UP	
	loadr	0	# adr var ID n: sym 1|0
	loads		
	loadc	2	
	sub		
	loads		
	loadc	0	
	cmpgt		
	jumpz	1000	
	loadr	0	# adr var ID f: sym 1|1
	loads		
	loadc	2	
	sub		
	loadc	1	
	sub		
	loads		
	loadr	0	# adr var ID n: sym 1|0
	loads		
	loadc	2	
	sub		
	loads		
	mult		
	loadr	0	# adr var ASSIGN f: sym 1|1
	loads		
	loadc	2	
	sub		
	loadc	1	
	sub		
	stores		
	loadr	0	# adr var ID n: sym 1|0
	loads		
	loadc	2	
	sub		
	loads		
	loadc	1	
	sub		
	loadr	0	# adr var ASSIGN n: sym 1|0
	loads		
	loadc	2	
	sub		
	stores		
	loadr	0	
	loads		
	call	1	# CALL fak
	loadr	0	# adr var ID n: sym 1|0
	loads		
	loadc	2	
	sub		
	loads		
	loadc	1	
	add		
	loadr	0	# adr var ASSIGN n: sym 1|0
	loads		
	loadc	2	
	sub		
	stores		
1000	nop		
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

