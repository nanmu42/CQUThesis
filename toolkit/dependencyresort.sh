#!/usr/bin/env sh

# To use texliveonfly to sort out the dependencies.
# Run once. When done, pass everything to latexmk

texliveonfly.py ../cquthesis.dtx
texliveonfly.py ../main.tex