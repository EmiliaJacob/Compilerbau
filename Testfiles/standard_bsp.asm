	loadc	0	
	dup		
	storer	0	
	loadc	0	
	call	RAM_UP	
	loadc	1	
	loadc	2	
	loadc	3	
	mult		
	add		
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

