	jump 0
10	loadr	0
	write
	return
0	loadc	1
	chs
	storer 0
	call	10
	loadc	17
	storer 0
	call	10
	return
