	loadc	0	
	dup		
	storer	0	
	loadc	7	
	call	RAM_UP	
	read		
	loadr	0	# adr var READ x: sym 0|0
	loadc	2	
	sub		
	stores		
	read		
	loadr	0	# adr var READ y: sym 0|1
	loadc	2	
	sub		
	loadc	1	
	sub		
	stores		
	loadr	0	
	call	1	# CALL multiply
	loadr	0	# adr var ID z: sym 0|2
	loadc	2	
	sub		
	loadc	2	
	sub		
	loads		
	write		
	read		
	loadr	0	# adr var READ x: sym 0|0
	loadc	2	
	sub		
	stores		
	read		
	loadr	0	# adr var READ y: sym 0|1
	loadc	2	
	sub		
	loadc	1	
	sub		
	stores		
	loadr	0	
	call	2	# CALL divide
	loadr	0	# adr var ID q: sym 0|3
	loadc	2	
	sub		
	loadc	3	
	sub		
	loads		
	write		
	loadr	0	# adr var ID r: sym 0|4
	loadc	2	
	sub		
	loadc	4	
	sub		
	loads		
	write		
	read		
	loadr	0	# adr var READ x: sym 0|0
	loadc	2	
	sub		
	stores		
	read		
	loadr	0	# adr var READ y: sym 0|1
	loadc	2	
	sub		
	loadc	1	
	sub		
	stores		
	loadr	0	
	call	3	# CALL gcd
	loadr	0	# adr var ID z: sym 0|2
	loadc	2	
	sub		
	loadc	2	
	sub		
	loads		
	write		
	read		
	loadr	0	# adr var READ n: sym 0|5
	loadc	2	
	sub		
	loadc	5	
	sub		
	stores		
	loadc	1	
	loadr	0	# adr var ASSIGN f: sym 0|6
	loadc	2	
	sub		
	loadc	6	
	sub		
	stores		
	loadr	0	
	call	4	# CALL fact
	loadr	0	# adr var ID f: sym 0|6
	loadc	2	
	sub		
	loadc	6	
	sub		
	loads		
	write		
	call	RAM_DOWN	
	return		


1	nop		# multiply
	loadc	2	
	call	RAM_UP	
	loadr	0	# adr var ID x: sym 1|0
	loads		
	loadc	2	
	sub		
	loads		
	loadr	0	# adr var ASSIGN a: sym 0|0
	loadc	2	
	sub		
	stores		
	loadr	0	# adr var ID y: sym 1|1
	loads		
	loadc	2	
	sub		
	loadc	1	
	sub		
	loads		
	loadr	0	# adr var ASSIGN b: sym 0|1
	loadc	2	
	sub		
	loadc	1	
	sub		
	stores		
	loadc	0	
	loadr	0	# adr var ASSIGN z: sym 1|2
	loads		
	loadc	2	
	sub		
	loadc	2	
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
	cmpgt		
	jumpz	1000	
	loadr	0	# adr var ID b: sym 0|1
	loadc	2	
	sub		
	loadc	1	
	sub		
	loads		
	loadc	2	
	mod		
	jumpz	1002	
	loadr	0	# adr var ID z: sym 1|2
	loads		
	loadc	2	
	sub		
	loadc	2	
	sub		
	loads		
	loadr	0	# adr var ID a: sym 0|0
	loadc	2	
	sub		
	loads		
	add		
	loadr	0	# adr var ASSIGN z: sym 1|2
	loads		
	loadc	2	
	sub		
	loadc	2	
	sub		
	stores		
1002	nop		
	loadc	2	
	loadr	0	# adr var ID a: sym 0|0
	loadc	2	
	sub		
	loads		
	mult		
	loadr	0	# adr var ASSIGN a: sym 0|0
	loadc	2	
	sub		
	stores		
	loadr	0	# adr var ID b: sym 0|1
	loadc	2	
	sub		
	loadc	1	
	sub		
	loads		
	loadc	2	
	div		
	loadr	0	# adr var ASSIGN b: sym 0|1
	loadc	2	
	sub		
	loadc	1	
	sub		
	stores		
	jump	1001	
1000	nop		
	call	RAM_DOWN	
	return		


2	nop		# divide
	loadc	1	
	call	RAM_UP	
	loadr	0	# adr var ID x: sym 1|0
	loads		
	loadc	2	
	sub		
	loads		
	loadr	0	# adr var ASSIGN r: sym 1|4
	loads		
	loadc	2	
	sub		
	loadc	4	
	sub		
	stores		
	loadc	0	
	loadr	0	# adr var ASSIGN q: sym 1|3
	loads		
	loadc	2	
	sub		
	loadc	3	
	sub		
	stores		
	loadr	0	# adr var ID y: sym 1|1
	loads		
	loadc	2	
	sub		
	loadc	1	
	sub		
	loads		
	loadr	0	# adr var ASSIGN w: sym 0|0
	loadc	2	
	sub		
	stores		
1004	nop		
	loadr	0	# adr var ID w: sym 0|0
	loadc	2	
	sub		
	loads		
	loadr	0	# adr var ID r: sym 1|4
	loads		
	loadc	2	
	sub		
	loadc	4	
	sub		
	loads		
	cmple		
	jumpz	1003	
	loadc	2	
	loadr	0	# adr var ID w: sym 0|0
	loadc	2	
	sub		
	loads		
	mult		
	loadr	0	# adr var ASSIGN w: sym 0|0
	loadc	2	
	sub		
	stores		
	jump	1004	
1003	nop		
1006	nop		
	loadr	0	# adr var ID w: sym 0|0
	loadc	2	
	sub		
	loads		
	loadr	0	# adr var ID y: sym 1|1
	loads		
	loadc	2	
	sub		
	loadc	1	
	sub		
	loads		
	cmpgt		
	jumpz	1005	
	loadc	2	
	loadr	0	# adr var ID q: sym 1|3
	loads		
	loadc	2	
	sub		
	loadc	3	
	sub		
	loads		
	mult		
	loadr	0	# adr var ASSIGN q: sym 1|3
	loads		
	loadc	2	
	sub		
	loadc	3	
	sub		
	stores		
	loadr	0	# adr var ID w: sym 0|0
	loadc	2	
	sub		
	loads		
	loadc	2	
	div		
	loadr	0	# adr var ASSIGN w: sym 0|0
	loadc	2	
	sub		
	stores		
	loadr	0	# adr var ID w: sym 0|0
	loadc	2	
	sub		
	loads		
	loadr	0	# adr var ID r: sym 1|4
	loads		
	loadc	2	
	sub		
	loadc	4	
	sub		
	loads		
	cmple		
	jumpz	1007	
	loadr	0	# adr var ID r: sym 1|4
	loads		
	loadc	2	
	sub		
	loadc	4	
	sub		
	loads		
	loadr	0	# adr var ID w: sym 0|0
	loadc	2	
	sub		
	loads		
	sub		
	loadr	0	# adr var ASSIGN r: sym 1|4
	loads		
	loadc	2	
	sub		
	loadc	4	
	sub		
	stores		
	loadr	0	# adr var ID q: sym 1|3
	loads		
	loadc	2	
	sub		
	loadc	3	
	sub		
	loads		
	loadc	1	
	add		
	loadr	0	# adr var ASSIGN q: sym 1|3
	loads		
	loadc	2	
	sub		
	loadc	3	
	sub		
	stores		
1007	nop		
	jump	1006	
1005	nop		
	call	RAM_DOWN	
	return		


3	nop		# gcd
	loadc	2	
	call	RAM_UP	
	loadr	0	# adr var ID x: sym 1|0
	loads		
	loadc	2	
	sub		
	loads		
	loadr	0	# adr var ASSIGN f: sym 0|0
	loadc	2	
	sub		
	stores		
	loadr	0	# adr var ID y: sym 1|1
	loads		
	loadc	2	
	sub		
	loadc	1	
	sub		
	loads		
	loadr	0	# adr var ASSIGN g: sym 0|1
	loadc	2	
	sub		
	loadc	1	
	sub		
	stores		
1009	nop		
	loadr	0	# adr var ID f: sym 0|0
	loadc	2	
	sub		
	loads		
	loadr	0	# adr var ID g: sym 0|1
	loadc	2	
	sub		
	loadc	1	
	sub		
	loads		
	cmpne		
	jumpz	1008	
	loadr	0	# adr var ID f: sym 0|0
	loadc	2	
	sub		
	loads		
	loadr	0	# adr var ID g: sym 0|1
	loadc	2	
	sub		
	loadc	1	
	sub		
	loads		
	cmplt		
	jumpz	1010	
	loadr	0	# adr var ID g: sym 0|1
	loadc	2	
	sub		
	loadc	1	
	sub		
	loads		
	loadr	0	# adr var ID f: sym 0|0
	loadc	2	
	sub		
	loads		
	sub		
	loadr	0	# adr var ASSIGN g: sym 0|1
	loadc	2	
	sub		
	loadc	1	
	sub		
	stores		
1010	nop		
	loadr	0	# adr var ID g: sym 0|1
	loadc	2	
	sub		
	loadc	1	
	sub		
	loads		
	loadr	0	# adr var ID f: sym 0|0
	loadc	2	
	sub		
	loads		
	cmplt		
	jumpz	1011	
	loadr	0	# adr var ID f: sym 0|0
	loadc	2	
	sub		
	loads		
	loadr	0	# adr var ID g: sym 0|1
	loadc	2	
	sub		
	loadc	1	
	sub		
	loads		
	sub		
	loadr	0	# adr var ASSIGN f: sym 0|0
	loadc	2	
	sub		
	stores		
1011	nop		
	jump	1009	
1008	nop		
	loadr	0	# adr var ID f: sym 0|0
	loadc	2	
	sub		
	loads		
	loadr	0	# adr var ASSIGN z: sym 1|2
	loads		
	loadc	2	
	sub		
	loadc	2	
	sub		
	stores		
	call	RAM_DOWN	
	return		


4	nop		# fact
	loadc	0	
	call	RAM_UP	
	loadr	0	# adr var ID n: sym 1|5
	loads		
	loadc	2	
	sub		
	loadc	5	
	sub		
	loads		
	loadc	1	
	cmpgt		
	jumpz	1012	
	loadr	0	# adr var ID n: sym 1|5
	loads		
	loadc	2	
	sub		
	loadc	5	
	sub		
	loads		
	loadr	0	# adr var ID f: sym 1|6
	loads		
	loadc	2	
	sub		
	loadc	6	
	sub		
	loads		
	mult		
	loadr	0	# adr var ASSIGN f: sym 1|6
	loads		
	loadc	2	
	sub		
	loadc	6	
	sub		
	stores		
	loadr	0	# adr var ID n: sym 1|5
	loads		
	loadc	2	
	sub		
	loadc	5	
	sub		
	loads		
	loadc	1	
	sub		
	loadr	0	# adr var ASSIGN n: sym 1|5
	loads		
	loadc	2	
	sub		
	loadc	5	
	sub		
	stores		
	loadr	0	
	loads		
	call	4	# CALL fact
1012	nop		
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

