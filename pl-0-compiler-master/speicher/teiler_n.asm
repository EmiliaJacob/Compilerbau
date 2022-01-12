

	loadc	0
	loadc	2
	call RAM_UP
	loadc	1
	loadr	0 	 # Adresse berechnen von 0/0
	dec	2
	dec	0
	stores
0x7ffbcd504438	nop
	loadr	0 	 # Adresse berechnen von 0/0
	dec	2
	dec	0
	loads
	loadc	10
	cmple
	jumpz	0x7ffbcd504440
	loadr	0 	# SL berechnen und auf stack schreiben, evlt kette
	call	square1
	loadr	0 	 # Adresse berechnen von 0/1
	dec	2
	dec	1
	loads
	write
	loadr	0 	 # Adresse berechnen von 0/0
	dec	2
	dec	0
	loads
	loadc	1
	add
	loadr	0 	 # Adresse berechnen von 0/0
	dec	2
	dec	0
	stores
	nop
	jump	0x7ffbcd504438
0x7ffbcd504440	nop
	nop
	call RAM_DOWN
	return


square1	nop
	loadc	0
	call RAM_UP
	loadr	0 	 # Adresse berechnen von 1/0
	loads
	dec	2
	dec	0
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


