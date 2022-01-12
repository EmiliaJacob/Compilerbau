

	loadc	0
	loadc	7
	call RAM_UP
	read
	loadr	0 	 # Adresse berechnen von 0/0
	dec	2
	dec	0
	stores
	read
	loadr	0 	 # Adresse berechnen von 0/1
	dec	2
	dec	1
	stores
	loadr	0 	# SL berechnen und auf stack schreiben, evlt kette
	call	multiply1
	loadr	0 	 # Adresse berechnen von 0/2
	dec	2
	dec	2
	loads
	write
	read
	loadr	0 	 # Adresse berechnen von 0/0
	dec	2
	dec	0
	stores
	read
	loadr	0 	 # Adresse berechnen von 0/1
	dec	2
	dec	1
	stores
	loadr	0 	# SL berechnen und auf stack schreiben, evlt kette
	call	divide2
	loadr	0 	 # Adresse berechnen von 0/3
	dec	2
	dec	3
	loads
	write
	loadr	0 	 # Adresse berechnen von 0/4
	dec	2
	dec	4
	loads
	write
	read
	loadr	0 	 # Adresse berechnen von 0/0
	dec	2
	dec	0
	stores
	read
	loadr	0 	 # Adresse berechnen von 0/1
	dec	2
	dec	1
	stores
	loadr	0 	# SL berechnen und auf stack schreiben, evlt kette
	call	gcd3
	loadr	0 	 # Adresse berechnen von 0/2
	dec	2
	dec	2
	loads
	write
	read
	loadr	0 	 # Adresse berechnen von 0/5
	dec	2
	dec	5
	stores
	loadc	1
	loadr	0 	 # Adresse berechnen von 0/6
	dec	2
	dec	6
	stores
	loadr	0 	# SL berechnen und auf stack schreiben, evlt kette
	call	fact4
	loadr	0 	 # Adresse berechnen von 0/6
	dec	2
	dec	6
	loads
	write
	nop
	call RAM_DOWN
	return


multiply1	nop
	loadc	2
	call RAM_UP
	loadr	0 	 # Adresse berechnen von 1/0
	loads
	dec	2
	dec	0
	loads
	loadr	0 	 # Adresse berechnen von 0/0
	dec	2
	dec	0
	stores
	loadr	0 	 # Adresse berechnen von 1/1
	loads
	dec	2
	dec	1
	loads
	loadr	0 	 # Adresse berechnen von 0/1
	dec	2
	dec	1
	stores
	loadc	0
	loadr	0 	 # Adresse berechnen von 1/2
	loads
	dec	2
	dec	2
	stores
0x7fa8c5504648	nop
	loadr	0 	 # Adresse berechnen von 0/1
	dec	2
	dec	1
	loads
	loadc	0
	cmpgt
	jumpz	0x7fa8c5504650
0x7fa8c55049f8	nop
	loadr	0 	 # Adresse berechnen von 0/1
	dec	2
	dec	1
	loads
	loadc	2
	mod
	loadc	1
	cmpeq
	jumpz	0x7fa8c5504a00
	loadr	0 	 # Adresse berechnen von 1/2
	loads
	dec	2
	dec	2
	loads
	loadr	0 	 # Adresse berechnen von 0/0
	dec	2
	dec	0
	loads
	add
	loadr	0 	 # Adresse berechnen von 1/2
	loads
	dec	2
	dec	2
	stores
0x7fa8c5504a00	nop
	loadc	2
	loadr	0 	 # Adresse berechnen von 0/0
	dec	2
	dec	0
	loads
	mult
	loadr	0 	 # Adresse berechnen von 0/0
	dec	2
	dec	0
	stores
	loadr	0 	 # Adresse berechnen von 0/1
	dec	2
	dec	1
	loads
	loadc	2
	div
	loadr	0 	 # Adresse berechnen von 0/1
	dec	2
	dec	1
	stores
	nop
	jump	0x7fa8c5504648
0x7fa8c5504650	nop
	nop
	call RAM_DOWN
	return


divide2	nop
	loadc	1
	call RAM_UP
	loadr	0 	 # Adresse berechnen von 1/0
	loads
	dec	2
	dec	0
	loads
	loadr	0 	 # Adresse berechnen von 1/4
	loads
	dec	2
	dec	4
	stores
	loadc	0
	loadr	0 	 # Adresse berechnen von 1/3
	loads
	dec	2
	dec	3
	stores
	loadr	0 	 # Adresse berechnen von 1/1
	loads
	dec	2
	dec	1
	loads
	loadr	0 	 # Adresse berechnen von 0/0
	dec	2
	dec	0
	stores
0x7fa8c5504ec8	nop
	loadr	0 	 # Adresse berechnen von 0/0
	dec	2
	dec	0
	loads
	loadr	0 	 # Adresse berechnen von 1/4
	loads
	dec	2
	dec	4
	loads
	cmple
	jumpz	0x7fa8c5504ed0
	loadc	2
	loadr	0 	 # Adresse berechnen von 0/0
	dec	2
	dec	0
	loads
	mult
	loadr	0 	 # Adresse berechnen von 0/0
	dec	2
	dec	0
	stores
	nop
	jump	0x7fa8c5504ec8
0x7fa8c5504ed0	nop
0x7fa8c5505128	nop
	loadr	0 	 # Adresse berechnen von 0/0
	dec	2
	dec	0
	loads
	loadr	0 	 # Adresse berechnen von 1/1
	loads
	dec	2
	dec	1
	loads
	cmpgt
	jumpz	0x7fa8c5505130
	loadc	2
	loadr	0 	 # Adresse berechnen von 1/3
	loads
	dec	2
	dec	3
	loads
	mult
	loadr	0 	 # Adresse berechnen von 1/3
	loads
	dec	2
	dec	3
	stores
	loadr	0 	 # Adresse berechnen von 0/0
	dec	2
	dec	0
	loads
	loadc	2
	div
	loadr	0 	 # Adresse berechnen von 0/0
	dec	2
	dec	0
	stores
0x7fa8c5505458	nop
	loadr	0 	 # Adresse berechnen von 0/0
	dec	2
	dec	0
	loads
	loadr	0 	 # Adresse berechnen von 1/4
	loads
	dec	2
	dec	4
	loads
	cmple
	jumpz	0x7fa8c5505460
	loadr	0 	 # Adresse berechnen von 1/4
	loads
	dec	2
	dec	4
	loads
	loadr	0 	 # Adresse berechnen von 0/0
	dec	2
	dec	0
	loads
	sub
	loadr	0 	 # Adresse berechnen von 1/4
	loads
	dec	2
	dec	4
	stores
	loadr	0 	 # Adresse berechnen von 1/3
	loads
	dec	2
	dec	3
	loads
	loadc	1
	add
	loadr	0 	 # Adresse berechnen von 1/3
	loads
	dec	2
	dec	3
	stores
0x7fa8c5505460	nop
	nop
	jump	0x7fa8c5505128
0x7fa8c5505130	nop
	nop
	call RAM_DOWN
	return


gcd3	nop
	loadc	2
	call RAM_UP
	loadr	0 	 # Adresse berechnen von 1/0
	loads
	dec	2
	dec	0
	loads
	loadr	0 	 # Adresse berechnen von 0/0
	dec	2
	dec	0
	stores
	loadr	0 	 # Adresse berechnen von 1/1
	loads
	dec	2
	dec	1
	loads
	loadr	0 	 # Adresse berechnen von 0/1
	dec	2
	dec	1
	stores
0x7fa8c55058a8	nop
	loadr	0 	 # Adresse berechnen von 0/0
	dec	2
	dec	0
	loads
	loadr	0 	 # Adresse berechnen von 0/1
	dec	2
	dec	1
	loads
	cmpne
	jumpz	0x7fa8c55058b0
0x7fa8c5505a28	nop
	loadr	0 	 # Adresse berechnen von 0/0
	dec	2
	dec	0
	loads
	loadr	0 	 # Adresse berechnen von 0/1
	dec	2
	dec	1
	loads
	cmplt
	jumpz	0x7fa8c5505a30
	loadr	0 	 # Adresse berechnen von 0/1
	dec	2
	dec	1
	loads
	loadr	0 	 # Adresse berechnen von 0/0
	dec	2
	dec	0
	loads
	sub
	loadr	0 	 # Adresse berechnen von 0/1
	dec	2
	dec	1
	stores
0x7fa8c5505a30	nop
0x7fa8c5505c18	nop
	loadr	0 	 # Adresse berechnen von 0/1
	dec	2
	dec	1
	loads
	loadr	0 	 # Adresse berechnen von 0/0
	dec	2
	dec	0
	loads
	cmplt
	jumpz	0x7fa8c5505c20
	loadr	0 	 # Adresse berechnen von 0/0
	dec	2
	dec	0
	loads
	loadr	0 	 # Adresse berechnen von 0/1
	dec	2
	dec	1
	loads
	sub
	loadr	0 	 # Adresse berechnen von 0/0
	dec	2
	dec	0
	stores
0x7fa8c5505c20	nop
	nop
	jump	0x7fa8c55058a8
0x7fa8c55058b0	nop
	loadr	0 	 # Adresse berechnen von 0/0
	dec	2
	dec	0
	loads
	loadr	0 	 # Adresse berechnen von 1/2
	loads
	dec	2
	dec	2
	stores
	nop
	call RAM_DOWN
	return


fact4	nop
	loadc	0
	call RAM_UP
0x7fa8c5505798	nop
	loadr	0 	 # Adresse berechnen von 1/5
	loads
	dec	2
	dec	5
	loads
	loadc	1
	cmpgt
	jumpz	0x7fa8c55057a0
	loadr	0 	 # Adresse berechnen von 1/5
	loads
	dec	2
	dec	5
	loads
	loadr	0 	 # Adresse berechnen von 1/6
	loads
	dec	2
	dec	6
	loads
	mult
	loadr	0 	 # Adresse berechnen von 1/6
	loads
	dec	2
	dec	6
	stores
	loadr	0 	 # Adresse berechnen von 1/5
	loads
	dec	2
	dec	5
	loads
	loadc	1
	sub
	loadr	0 	 # Adresse berechnen von 1/5
	loads
	dec	2
	dec	5
	stores
	loadr	0 	# SL berechnen und auf stack schreiben, evlt kette
	loads
	call	fact4
0x7fa8c55057a0	nop
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


