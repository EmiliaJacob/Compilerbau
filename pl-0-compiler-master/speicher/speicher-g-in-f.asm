	loadc	0	
	dup		
	storer	0	
	loadc	2	
	call	RAM_UP	
	loadc	10	
	loadr	0	# Adresse von 0/0
	dec	2	
	dec	0	
	stores		
	loadc	40	
	loadr	0	# Adresse von 0/1
	dec	2	
	dec	1	
	stores		
	loadr	0	
	call	1	# Call f
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
	call	RAM_DOWN	
	return		

1	nop		# f
	loadc	2	
	call	RAM_UP	
	loadc	11	
	loadr	0	# Adresse von 1/0
	loads		
	dec	2	
	dec	0	
	stores		
	loadc	21	
	loadr	0	# Adresse von 0/0
	dec	2	
	dec	0	
	stores		
	loadc	41	
	loadr	0	# Adresse von 0/1
	dec	2	
	dec	1	
	stores		
	loadr	0	
	call	2	# Call g
	loadr	0	# Adresse von 1/0
	loads		
	dec	2	
	dec	0	
	loads		
	write		
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
	call	RAM_DOWN	
	return		

2	nop		# g
	loadc	2	
	call	RAM_UP	
	loadc	12	
	loadr	0	# Adresse von 2/0
	loads		
	loads		
	dec	2	
	dec	0	
	stores		
	loadc	22	
	loadr	0	# Adresse von 1/0
	loads		
	dec	2	
	dec	0	
	stores		
	loadc	32	
	loadr	0	# Adresse von 0/0
	dec	2	
	dec	0	
	stores		
	loadc	42	
	loadr	0	# Adresse von 0/1
	dec	2	
	dec	1	
	stores		
	loadr	0	# Adresse von 2/0
	loads		
	loads		
	dec	2	
	dec	0	
	loads		
	write		
	loadr	0	# Adresse von 1/0
	loads		
	dec	2	
	dec	0	
	loads		
	write		
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

