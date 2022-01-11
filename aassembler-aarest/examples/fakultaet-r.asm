	jump	0
1	loadr	0
	loadc	0
	cmpgt
	jumpz	11
	loadr	0
	loadr	1
	mult
	storer	1
	loadr	0
	loadc	1
	sub
	storer	0
	call 1
11	return
0	read
	storer	0	# Rekursionslevel
	loadc	1
	storer	1	# Fakultaet
	call	1
	loadr	1
	write
