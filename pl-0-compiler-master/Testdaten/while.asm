	loadc	0
	storer	0
	loadr	0
	loadc	2
	call	RAM_UP
	loadc	0
	loadr	0
	dec	2
	dec	0
	stores	
	loadc	1
	chs	
	loadr	0
	dec	2
	dec	0
	stores	
	jumpz	1
	read	
	loadr	0
	dec	2
	dec	0
	stores	
	loadr	0
	dec	2
	dec	0
	loadc	1
	add	
	loadr	0
	dec	2
	dec	0
	stores	
	jump	-1
	loadr	0
	dec	2
	dec	0
	loads	
	write	
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

