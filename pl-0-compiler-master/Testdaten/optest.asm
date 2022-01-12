	loadc	0	
	dup		
	storer	0	
	loadc	0	
	call	RAM_UP	
	loadc	50	
	loadc	5	
	div		
	write		
	loadc	50	
	loadc	7	
	div		
	loadc	7	
	mult		
	write		
	loadc	50	
	loadc	5	
	div		
	loadc	5	
	mult		
	write		
	loadc	1	
	loadc	2	
	loadc	3	
	mult		
	add		
	write		
	loadc	1	
	loadc	2	
	mult		
	loadc	3	
	loadc	4	
	mult		
	add		
	write		
	loadc	1	
	loadc	2	
	add		
	loadc	3	
	add		
	loadc	4	
	add		
	loadc	5	
	add		
	write		
	loadc	1	
	loadc	2	
	add		
	loadc	2	
	loadc	3	
	add		
	mult		
	write		
	loadc	5	
	chs		
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

