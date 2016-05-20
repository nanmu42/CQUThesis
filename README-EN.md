# About CQUThesis
CQUThesis stands for Chongqing University Thesis Template for LaTeX, bearing the ability to support bachelor,
master, doctor dissertations.

# Installing
* To create the package file, run:
```
	latex cquthesis.ins
```
* To finish the installation you have to move the following files into a directory searched by TeX:(The recommended directory is TEXMF/tex/latex/cquthesis)

   cquthesis.cls
   cquthesis.cfg
   cqunumerical.bst

* To produce the documentation please run these command:
```
  xelatex cquthesis.dtx
  makeindex -s gind.ist -o cquthesis.ind cquthesis.idx
  makeindex -s gglo.ist -o cquthesis.gls cquthesis.glo
  xelatex cquthesis.dtx
  xelatex cquthesis.dtx
```

* Run these command will get you a typeseting example:
```
  xelatex main.tex
  bibtex main.tex
  xelatex main.tex
  xelatex main.tex
```
* For further info, please go to: https://github.com/nanmu42/CQUThesis

Happy TeXing!

# Acknowledgements
The author would like to acknowledge these contributors for their efforts and, essentially, beautiful mind:

* [The CTeX Community](https://github.com/CTeX-org/ctex-kit)
* [XUE, Ruini](https://github.com/xueruini/thuthesis)
* [USTC TeX User Group](https://github.com/ustctug/gbt-7714-20155)