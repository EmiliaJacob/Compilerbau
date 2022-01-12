	loadc	0	
	dup		
	storer	0	
	loadc	7	
	call	RAM_UP	
	read		
	loadr	0	# Adresse von 0/0
	dec	2	
	dec	0	
	stores		
	read		
	loadr	0	# Adresse von 0/1
	dec	2	
	dec	1	
	stores		
	loadr	0	
	call	1	# Call multiply
	loadr	0	# Adresse von 0/2
	dec	2	
	dec	2	
	loads		
	write		
	read		
	loadr	0	# Adresse von 0/0
	dec	2	
	dec	0	
	stores		
	read		
	loadr	0	# Adresse von 0/1
	dec	2	
	dec	1	
	stores		
	loadr	0	
	call	2	# Call divide
	loadr	0	# Adresse von 0/3
	dec	2	
	dec	3	
	loads		
	write		
	loadr	0	# Adresse von 0/4
	dec	2	
	dec	4	
	loads		
	write		
	read		
	loadr	0	# Adresse von 0/0
	dec	2	
	dec	0	
	stores		
	read		
	loadr	0	# Adresse von 0/1
	dec	2	
	dec	1	
	stores		
	loadr	0	
	call	3	# Call gcd
	loadr	0	# Adresse von 0/2
	dec	2	
	dec	2	
	loads		
	write		
	read		
	loadr	0	# Adresse von 0/5
	dec	2	
	dec	5	
	stores		
	loadc	1	
	loadr	0	# Adresse von 0/6
	dec	2	
	dec	6	
	stores		
	loadr	0	
	call	4	# Call fact
	loadr	0	# Adresse von 0/6
	dec	2	
	dec	6	
	loads		
	write		
	call	RAM_DOWN	
	return		

1	nop		# multiply
	loadc	2	
	call	RAM_UP	
	loadr	0	# Adresse von 1/0
	loads		
	dec	2	
	dec	0	
	loads		
	loadr	0	# Adresse von 0/0
	dec	2	
	dec	0	
	stores		
	loadr	0	# Adresse von 1/1
	loads		
	dec	2	
	dec	1	
	loads		
	loadr	0	# Adresse von 0/1
	dec	2	
	dec	1	
	stores		
	loadc	0	
	loadr	0	# Adresse von 1/2
	loads		
	dec	2	
	dec	2	
	stores		
1001	nop		
	loadr	0	# Adresse von 0/1
	dec	2	
	dec	1	
	loads		
	loadc	0	
	cmpgt		
	jumpz	1000	
	loadr	0	# Adresse von 0/1
	dec	2	
	dec	1	
	loads		
	loadc	2	
	mod		
	jumpz	1002	
	loadr	0	# Adresse von 1/2
	loads		
	dec	2	
	dec	2	
	loads		
	loadr	0	# Adresse von 0/0
	dec	2	
	dec	0	
	loads		
	add		
	loadr	0	# Adresse von 1/2
	loads		
	dec	2	
	dec	2	
	stores		
1002	nop		
	loadc	2	
	loadr	0	# Adresse von 0/0
	dec	2	
	dec	0	
	loads		
	mult		
	loadr	0	# Adresse von 0/0
	dec	2	
	dec	0	
	stores		
	loadr	0	# Adresse von 0/1
	dec	2	
	dec	1	
	loads		
	loadc	2	
	div		
	loadr	0	# Adresse von 0/1
	dec	2	
	dec	1	
	stores		
	jump	1001	
1000	nop		
	call	RAM_DOWN	
	return		

2	nop		# divide
	loadc	1	
	call	RAM_UP	
	loadr	0	# Adresse von 1/0
	loads		
	dec	2	
	dec	0	
	loads		
	loadr	0	# Adresse von 1/4
	loads		
	dec	2	
	dec	4	
	stores		
	loadc	0	
	loadr	0	# Adresse von 1/3
	loads		
	dec	2	
	dec	3	
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
1004	nop		
	loadr	0	# Adresse von 0/0
	dec	2	
	dec	0	
	loads		
	loadr	0	# Adresse von 1/4
	loads		
	dec	2	
	dec	4	
	loads		
	cmple		
	jumpz	1003	
	loadc	2	
	loadr	0	# Adresse von 0/0
	dec	2	
	dec	0	
	loads		
	mult		
	loadr	0	# Adresse von 0/0
	dec	2	
	dec	0	
	stores		
	jump	1004	
1003	nop		
1006	nop		
	loadr	0	# Adresse von 0/0
	dec	2	
	dec	0	
	loads		
	loadr	0	# Adresse von 1/1
	loads		
	dec	2	
	dec	1	
	loads		
	cmpgt		
	jumpz	1005	
	loadc	2	
	loadr	0	# Adresse von 1/3
	loads		
	dec	2	
	dec	3	
	loads		
	mult		
	loadr	0	# Adresse von 1/3
	loads		
	dec	2	
	dec	3	
	stores		
	loadr	0	# Adresse von 0/0
	dec	2	
	dec	0	
	loads		
	loadc	2	
	div		
	loadr	0	# Adresse von 0/0
	dec	2	
	dec	0	
	stores		
	loadr	0	# Adresse von 0/0
	dec	2	
	dec	0	
	loads		
	loadr	0	# Adresse von 1/4
	loads		
	dec	2	
	dec	4	
	loads		
	cmple		
	jumpz	1007	
	loadr	0	# Adresse von 1/4
	loads		
	dec	2	
	dec	4	
	loads		
	loadr	0	# Adresse von 0/0
	dec	2	
	dec	0	
	loads		
	sub		
	loadr	0	# Adresse von 1/4
	loads		
	dec	2	
	dec	4	
	stores		
	loadr	0	# Adresse von 1/3
	loads		
	dec	2	
	dec	3	
	loads		
	loadc	1	
	add		
	loadr	0	# Adresse von 1/3
	loads		
	dec	2	
	dec	3	
	stores		
1007	nop		
	jump	1006	
1005	nop		
	call	RAM_DOWN	
	return		

3	nop		# gcd
	loadc	2	
	call	RAM_UP	
	loadr	0	# Adresse von 1/0
	loads		
	dec	2	
	dec	0	
	loads		
	loadr	0	# Adresse von 0/0
	dec	2	
	dec	0	
	stores		
	loadr	0	# Adresse von 1/1
	loads		
	dec	2	
	dec	1	
	loads		
	loadr	0	# Adresse von 0/1
	dec	2	
	dec	1	
	stores		
1009	nop		
	loadr	0	# Adresse von 0/0
	dec	2	
	dec	0	
	loads		
	loadr	0	# Adresse von 0/1
	dec	2	
	dec	1	
	loads		
	cmpne		
	jumpz	1008	
	loadr	0	# Adresse von 0/0
	dec	2	
	dec	0	
	loads		
	loadr	0	# Adresse von 0/1
	dec	2	
	dec	1	
	loads		
	cmplt		
	jumpz	1010	
	loadr	0	# Adresse von 0/1
	dec	2	
	dec	1	
	loads		
	loadr	0	# Adresse von 0/0
	dec	2	
	dec	0	
	loads		
	sub		
	loadr	0	# Adresse von 0/1
	dec	2	
	dec	1	
	stores		
1010	nop		
	loadr	0	# Adresse von 0/1
	dec	2	
	dec	1	
	loads		
	loadr	0	# Adresse von 0/0
	dec	2	
	dec	0	
	loads		
	cmplt		
	jumpz	1011	
	loadr	0	# Adresse von 0/0
	dec	2	
	dec	0	
	loads		
	loadr	0	# Adresse von 0/1
	dec	2	
	dec	1	
	loads		
	sub		
	loadr	0	# Adresse von 0/0
	dec	2	
	dec	0	
	stores		
1011	nop		
	jump	1009	
1008	nop		
	loadr	0	# Adresse von 0/0
	dec	2	
	dec	0	
	loads		
	loadr	0	# Adresse von 1/2
	loads		
	dec	2	
	dec	2	
	stores		
	call	RAM_DOWN	
	return		

4	nop		# fact
	loadc	0	
	call	RAM_UP	
	loadr	0	# Adresse von 1/5
	loads		
	dec	2	
	dec	5	
	loads		
	loadc	1	
	cmpgt		
	jumpz	1012	
	loadr	0	# Adresse von 1/5
	loads		
	dec	2	
	dec	5	
	loads		
	loadr	0	# Adresse von 1/6
	loads		
	dec	2	
	dec	6	
	loads		
	mult		
	loadr	0	# Adresse von 1/6
	loads		
	dec	2	
	dec	6	
	stores		
	loadr	0	# Adresse von 1/5
	loads		
	dec	2	
	dec	5	
	loads		
	loadc	1	
	sub		
	loadr	0	# Adresse von 1/5
	loads		
	dec	2	
	dec	5	
	stores		
	loadr	0	
	loads		
	call	4	# Call fact
1012	nop		
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

