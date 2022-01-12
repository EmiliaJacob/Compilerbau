	loadc	0	
	dup		
	storer	0	
	loadc	3	
	call	RAM_UP	
	loadc	100	
	loadr	0	# Adresse von 0/0
	dec	2	
	dec	0	
	stores		
	loadr	0	
	call	2	# Call primes
	call	RAM_DOWN	
	return		

1	nop		# isprime
	loadc	1	
	call	RAM_UP	
	loadc	1	
	loadr	0	# Adresse von 1/2
	loads		
	dec	2	
	dec	2	
	stores		
	loadc	2	
	loadr	0	# Adresse von 0/0
	dec	2	
	dec	0	
	stores		
1001	nop		
	loadr	0	# Adresse von 0/0
	dec	2	
	dec	0	
	loads		
	loadr	0	# Adresse von 1/1
	loads		
	dec	2	
	dec	1	
	loads		
	cmplt		
	jumpz	1000	
	loadr	0	# Adresse von 1/1
	loads		
	dec	2	
	dec	1	
	loads		
	loadr	0	# Adresse von 0/0
	dec	2	
	dec	0	
	loads		
	div		
	loadr	0	# Adresse von 0/0
	dec	2	
	dec	0	
	loads		
	mult		
	loadr	0	# Adresse von 1/1
	loads		
	dec	2	
	dec	1	
	loads		
	cmpeq		
	jumpz	1002	
	loadc	0	
	loadr	0	# Adresse von 1/2
	loads		
	dec	2	
	dec	2	
	stores		
	loadr	0	# Adresse von 1/1
	loads		
	dec	2	
	dec	1	
	loads		
	loadr	0	# Adresse von 0/0
	dec	2	
	dec	0	
	stores		
1002	nop		
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

2	nop		# primes
	loadc	0	
	call	RAM_UP	
	loadc	2	
	loadr	0	# Adresse von 1/1
	loads		
	dec	2	
	dec	1	
	stores		
1004	nop		
	loadr	0	# Adresse von 1/1
	loads		
	dec	2	
	dec	1	
	loads		
	loadr	0	# Adresse von 1/0
	loads		
	dec	2	
	dec	0	
	loads		
	cmplt		
	jumpz	1003	
	loadr	0	
	loads		
	call	1	# Call isprime
	loadr	0	# Adresse von 1/2
	loads		
	dec	2	
	dec	2	
	loads		
	loadc	1	
	cmpeq		
	jumpz	1005	
	loadr	0	# Adresse von 1/1
	loads		
	dec	2	
	dec	1	
	loads		
	write		
1005	nop		
	loadr	0	# Adresse von 1/1
	loads		
	dec	2	
	dec	1	
	loads		
	loadc	1	
	add		
	loadr	0	# Adresse von 1/1
	loads		
	dec	2	
	dec	1	
	stores		
	jump	1004	
1003	nop		
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

