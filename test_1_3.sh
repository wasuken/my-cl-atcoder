#!/bin/bash


ros -L sbcl -Q -- --script main.lisp < 1.txt
echo ""
ros -L sbcl -Q -- --script main.lisp < 2.txt
# ros -L sbcl -Q -- --script main.lisp < 3.txt
