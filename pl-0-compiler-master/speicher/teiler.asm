	loadc	0	
	dup		
	storer	0	
	loadc	2	
	call	RAM_UP	
	loadc	1	
	loadr	0	# Adresse von 0/0
	dec	2	
	dec	0	
	stores		
1001	nop		
	loadr	0	# Adresse von 0/0
	dec	2	
	dec	0	
	loads		
	loadc	10	
	cmple		
	jumpz	1000	
	loadr	0	
	call	1	# Call square
	loadr	0	# Adresse von 0/1
	dec	2	
	dec	1	
	loads		
	write		
	loadr	0	# Adresse von 0/0
	dec	2	
	dec	0	
	loads		
	loadc	1	
	add		
	loadr	0	# Adresse von 0/0
	dec	2	
	dec	0	
	stores		
	jump	1001	
1000	nop		
	call	RAM_DOWN	
	return		

1	nop		# square
	loadc	0	
	call	RAM_UP	
	loadr	0	# Adresse von 1/0
	loads		
	dec	2	
	dec	0	
	loads		
	loadr	0	# Adresse von 1/0
	loads		
	dec	2	
	dec	0	
	loads		
	mult		
	loadr	0	# Adresse von 1/1
	loads		
	dec	2	
	dec	1	
	stores		
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

