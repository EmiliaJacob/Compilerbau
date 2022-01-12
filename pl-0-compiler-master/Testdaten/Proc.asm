	call	1
	call	2

f	nop	
	call	RAM_UP
	call	RAM_DOWN

g	nop	
	call	RAM_UP
	call	3
	call	RAM_DOWN

f	nop	
	call	RAM_UP
	call	RAM_DOWN
	return	
RAM_UP	loadr	0
	add	
	inc	2
	dup	2
	dec	1
	loadr	0
	swap	
	stores	
	dup	
	storer	0
	stores	
	return	0

RAM_DOWN	loadr	0
	dec	1
	loads	
	storer	0
	return	

