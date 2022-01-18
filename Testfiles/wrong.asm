	loadc	0	
	dup		
	storer	0	
	loadc	3	
	call	RAM_UP	
	loadc	0	
	loadr	0	# adr var ASSIGN a: sym 0|0
	loadc	2	
	sub		
	stores		
	loadc	1	
	chs		
	loadr	0	# adr var ASSIGN b: sym 0|1
	loadc	2	
	sub		
	loadc	1	
	sub		
	stores		
1001	nop		
	loadr	0	# adr var ID b: sym 0|1
	loadc	2	
	sub		
	loadc	1	
	sub		
	loads		
	loadc	0	
	cmplt		
	jumpz	1000	
	read		
	loadr	0	# adr var READ b: sym 0|1
	loadc	2	
	sub		
	loadc	1	
	sub		
	stores		
	loadr	0	# adr var ID a: sym 0|0
	loadc	2	
	sub		
	loads		
	loadc	1	
	add		
	loadr	0	# adr var ASSIGN a: sym 0|0
	loadc	2	
	sub		
	stores		
	jump	1001	
1000	nop		
	loadr	0	# adr var ID a: sym 0|0
	loadc	2	
	sub		
	loads		
	write		
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

