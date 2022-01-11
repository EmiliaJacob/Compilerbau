# Gib die Zahlen 0...4 aus
	loadc	0	# Initialisiere mit 0
	storer	0
1	loadr	0	# Schleifenbedingung
	loadc	5
	cmplt
	jumpz	2	# Feierabend?
	loadr	0
	write
	loadr	0	# Incementieren
	loadc	1
	add
	storer	0
	jump	1	# Und wieder nach oben...
2				# Programmende
