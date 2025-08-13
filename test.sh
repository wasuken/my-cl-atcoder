#!/bin/bash

for file in [0-9]*.txt; do
    [ -f "$file" ] && ros -L sbcl -Q -- --script main.lisp < "$file"
    echo ""
done
