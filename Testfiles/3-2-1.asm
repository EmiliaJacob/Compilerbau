	loadc	0	
	dup		
	storer	0	
	loadc	0	
	call	RAM_UP	
	loadc	3	
	loadc	2	
	sub		
	loadc	1	
	sub		
	write		
	call	RAM_DOWN	
	return		

RAM_UP	loadr	0	
	add		
	inc	2	
	dup		
	dec	1	
	loadr	0	
	swap		
	stores		
	dup		
	storer	0	
	stores		
	return		

RAM_DOWN	loadr	0	
	dec	1	
	loads		
	storer	0	
	return		

