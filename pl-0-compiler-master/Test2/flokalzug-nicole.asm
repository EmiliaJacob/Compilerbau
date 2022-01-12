

	loadc	0
	loadc	2
	call RAM_UP
	loadc	10
	loadr	0 	 # Adresse berechnen von 0/0
	dec	2
	dec	0
	stores
	loadc	40
	loadr	0 	 # Adresse berechnen von 0/1
	dec	2
	dec	1
	stores
	loadr	0 	# SL berechnen und auf stack schreiben, evlt kette
	call	g1
	loadr	0 	 # Adresse berechnen von 0/0
	dec	2
	dec	0
	loads
	write
	loadr	0 	 # Adresse berechnen von 0/1
	dec	2
	dec	1
	loads
	write
	nop
	call RAM_DOWN
	return


g1	nop
	loadc	2
	call RAM_UP
	loadc	32
	loadr	0 	 # Adresse berechnen von 0/0
	dec	2
	dec	0
	stores
	loadc	42
	loadr	0 	 # Adresse berechnen von 0/1
	dec	2
	dec	1
	stores
0x7fa64bc05f68	nop
	loadr	0 	 # Adresse berechnen von 1/0
	loads
	dec	2
	dec	0
	loads
	loadc	10
	cmpeq
	jumpz	0
	loadr	0 	# SL berechnen und auf stack schreiben, evlt kette
	call	f2
0	nop
0x7fa64bc06088	nop
	loadr	0 	 # Adresse berechnen von 1/0
	loads
	dec	2
	dec	0
	loads
	loadc	11
	cmpeq
	jumpz	1
	loadc	12
	loadr	0 	 # Adresse berechnen von 1/0
	loads
	dec	2
	dec	0
	stores
1	nop
	nop
	call RAM_DOWN
	return


f2	nop
	loadc	2
	call RAM_UP
	loadc	11
	loadr	0 	 # Adresse berechnen von 2/0
	loads
	loads
	dec	2
	dec	0
	stores
	loadc	21
	loadr	0 	 # Adresse berechnen von 0/0
	dec	2
	dec	0
	stores
	loadc	31
	loadr	0 	 # Adresse berechnen von 1/0
	loads
	dec	2
	dec	0
	stores
	loadc	41
	loadr	0 	 # Adresse berechnen von 0/1
	dec	2
	dec	1
	stores
	loadr	0 	# SL berechnen und auf stack schreiben, evlt kette
	loads
	loads
	call	g1
	loadr	0 	 # Adresse berechnen von 2/0
	loads
	loads
	dec	2
	dec	0
	loads
	write
	loadr	0 	 # Adresse berechnen von 0/0
	dec	2
	dec	0
	loads
	write
	loadr	0 	 # Adresse berechnen von 1/0
	loads
	dec	2
	dec	0
	loads
	write
	loadr	0 	 # Adresse berechnen von 0/1
	dec	2
	dec	1
	loads
	write
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


