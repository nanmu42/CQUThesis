#!/usr/bin/env sh

# To use texliveonfly to sort out the dependencies.
# Run once. When done, pass everything to latexmk

./toolkit/texliveonfly.py cquthesis.dtx
./toolkit/texliveonfly.py main.tex