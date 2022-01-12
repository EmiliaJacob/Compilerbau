# Betragsberechnung ueber Funktion
		read
		call betrag
		write
		read
		call betrag
		write
		return

betrag	dup
		loadc	0
		cmpge
		jumpnz	betrag2
		chs
betrag2	return
