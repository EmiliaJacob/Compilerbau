# (5 * -(1 + 2 * 3)) + ( 3 + (1 + 2 * 3))
	loadc	1
	loadc	2
	loadc	3
	mult
	add			# (1 + 2 * 3) fertig
	dup
	chs
	loadc	5
	mult		# Erster Summand fertig
	swap
	loadc	3
	add			# Zweiter Summand fertig
	add
	write
