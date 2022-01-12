

	loadc	0
	loadc	2
	call RAM_UP
	read
	loadr	0 	 # Adresse berechnen von 0/0
	dec	2
	dec	0
	stores
	loadc	1
	loadr	0 	 # Adresse berechnen von 0/1
	dec	2
	dec	1
	stores
	loadr	0 	# SL berechnen und auf stack schreiben, evlt kette
	call	fak1
	loadr	0 	 # Adresse berechnen von 0/1
	dec	2
	dec	1
	loads
	write
	nop
	call RAM_DOWN
	return


fak1	nop
	loadc	0
	call RAM_UP
0x7fac1dc059b8	nop
	loadr	0 	 # Adresse berechnen von 1/0
	loads
	dec	2
	dec	0
	loads
	loadc	0
	cmpgt
	jumpz	0
	loadr	0 	 # Adresse berechnen von 1/1
	loads
	dec	2
	dec	1
	loads
	loadr	0 	 # Adresse berechnen von 1/0
	loads
	dec	2
	dec	0
	loads
	mult
	loadr	0 	 # Adresse berechnen von 1/1
	loads
	dec	2
	dec	1
	stores
	loadr	0 	 # Adresse berechnen von 1/0
	loads
	dec	2
	dec	0
	loads
	loadc	1
	sub
	loadr	0 	 # Adresse berechnen von 1/0
	loads
	dec	2
	dec	0
	stores
	loadr	0 	# SL berechnen und auf stack schreiben, evlt kette
	loads
	call	fak1
	loadr	0 	 # Adresse berechnen von 1/0
	loads
	dec	2
	dec	0
	loads
	loadc	1
	add
	loadr	0 	 # Adresse berechnen von 1/0
	loads
	dec	2
	dec	0
	stores
0	nop
	nop
	call RAM_DOWN
	return
RAM_UP	loadr 0
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


