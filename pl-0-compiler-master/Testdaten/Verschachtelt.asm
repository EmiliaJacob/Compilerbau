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
	jumpz	1
	loadc	3
	jumpz	2
	jumpz	3
	jumpz	4
	return	
