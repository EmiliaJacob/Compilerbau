    loadc   0
    storer  0
    loadc   1
    chs
    storer  1
2   nop2
    loadr   1
    loadc   0
    cmplt
    jumpz   1
    read
    storer  1
    loadr   0
    loadc   1
    add
    storer  0
    jump    2
1   nop1
    loadr   0
    write