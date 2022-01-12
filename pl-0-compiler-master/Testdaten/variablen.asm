	loadc	0	
	dup		
	storer	0	
	loadc	4	
	call	RAM_UP	
	loadc	44	
	loadr	0	# Adresse von 0/0
	dec	2	
	dec	0	
	stores		
	loadc	55	
	loadr	0	# Adresse von 0/1
	dec	2	
	dec	1	
	stores		
	loadc	66	
	loadr	0	# Adresse von 0/2
	dec	2	
	dec	2	
	stores		
	loadc	77	
	loadr	0	# Adresse von 0/3
	dec	2	
	dec	3	
	stores		
	loadr	0	# Adresse von 0/0
	dec	2	
	dec	0	
	loads		
	write		
	loadr	0	# Adresse von 0/1
	dec	2	
	dec	1	
	loads		
	write		
	loadr	0	# Adresse von 0/2
	dec	2	
	dec	2	
	loads		
	write		
	loadr	0	# Adresse von 0/3
	dec	2	
	dec	3	
	loads		
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

