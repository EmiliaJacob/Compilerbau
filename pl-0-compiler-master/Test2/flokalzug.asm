	loadc	0
	storer	0
	loadr	0
	loadc	2
	call	RAM_UP
	loadc	10
	loadr	0
	dec	2
	dec	0
	stores	
	loadc	40
	loadr	0
	dec	2
	dec	1
	stores	
	call	1
	loadr	0
	dec	2
	dec	0
	loads	
	write	
	loadr	0
	dec	2
	dec	1
	loads	
	write	
	return	

1	nop	
	loadr	0
	loadc	2
	call	RAM_UP
	loadc	32
	loadr	0
	dec	2
	dec	0
	stores	
	loadc	42
	loadr	0
	dec	2
	dec	1
	stores	
	jumpz	1
	call	2
	jumpz	2
	loadc	12
	loadr	0
	loads	
	dec	2
	dec	0
	stores	
	call	RAM_DOWN
	return	

2	nop	
	loadr	0
	loadc	2
	call	RAM_UP
	loadc	11
	loadr	0
	loads	
	loads	
	dec	2
	dec	0
	stores	
	loadc	21
	loadr	0
	dec	2
	dec	0
	stores	
	loadc	31
	loadr	0
	loads	
	dec	2
	dec	0
	stores	
	loadc	41
	loadr	0
	dec	2
	dec	1
	stores	
	call	1
	loadr	0
	loads	
	loads	
	dec	2
	dec	0
	loads	
	write	
	loadr	0
	dec	2
	dec	0
	loads	
	write	
	loadr	0
	loads	
	dec	2
	dec	0
	loads	
	write	
	loadr	0
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

