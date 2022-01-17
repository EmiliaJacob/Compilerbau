	loadc	0	
	dup		
	storer	0	
	loadc	2	
	call	RAM_UP	
	loadc	10	
	loadr	0	# adr var ASSIGN a: sym 0|0
	loadc	2	
	sub		
	stores		
	loadc	40	
	loadr	0	# adr var ASSIGN d: sym 0|1
	loadc	2	
	sub		
	loadc	1	
	sub		
	stores		
	loadr	0	
	call	1	# CALL g
	loadr	0	# adr var ID a: sym 0|0
	loadc	2	
	sub		
	loads		
	write		
	loadr	0	# adr var ID d: sym 0|1
	loadc	2	
	sub		
	loadc	1	
	sub		
	loads		
	write		
	call	RAM_DOWN	
	return		


1	nop		# g
	loadc	2	
	call	RAM_UP	
	loadc	32	
	loadr	0	# adr var ASSIGN c: sym 0|0
	loadc	2	
	sub		
	stores		
	loadc	42	
	loadr	0	# adr var ASSIGN d: sym 0|1
	loadc	2	
	sub		
	loadc	1	
	sub		
	stores		
	loadr	0	# adr var ID a: sym 1|0
	loads		
	loadc	2	
	sub		
	loads		
	loadc	10	
	cmpeq		
	jumpz	1000	
	loadr	0	
	call	2	# CALL f
1000	nop		
	loadr	0	# adr var ID a: sym 1|0
	loads		
	loadc	2	
	sub		
	loads		
	loadc	11	
	cmpeq		
	jumpz	1001	
	loadc	12	
	loadr	0	# adr var ASSIGN a: sym 1|0
	loads		
	loadc	2	
	sub		
	stores		
1001	nop		
	call	RAM_DOWN	
	return		


2	nop		# f
	loadc	2	
	call	RAM_UP	
	loadc	11	
	loadr	0	# adr var ASSIGN a: sym 2|0
	loads		
	loads		
	loadc	2	
	sub		
	stores		
	loadc	21	
	loadr	0	# adr var ASSIGN b: sym 0|0
	loadc	2	
	sub		
	stores		
	loadc	31	
	loadr	0	# adr var ASSIGN c: sym 1|0
	loads		
	loadc	2	
	sub		
	stores		
	loadc	41	
	loadr	0	# adr var ASSIGN d: sym 0|1
	loadc	2	
	sub		
	loadc	1	
	sub		
	stores		
	loadr	0	
	loads		
	loads		
	call	1	# CALL g
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

