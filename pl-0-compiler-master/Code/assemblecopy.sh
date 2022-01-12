#!/bin/bash

./pl-0 $1 &&../aassembler-aarest/aassembler $1 && cat $1.json | xclip -selection clipboard