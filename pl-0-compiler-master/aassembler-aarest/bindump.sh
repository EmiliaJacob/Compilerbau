#!/bin/bash
hexdump -e '2/4 "%8d " "\n"' $1 |
	awk '{printf("%4d%s\n", NR-1,$0)}'
