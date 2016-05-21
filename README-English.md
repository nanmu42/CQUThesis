# About CQUThesis
CQUThesis stands for Chongqing University Thesis Template for LaTeX, bearing the ability to support bachelor, master, doctor dissertations with grace and speed.

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

# Question, Contribution and Contact
Feel free to raise any question, and any possible contribution is highly appreciated.
Submit a issue at [Github](https://github.com/nanmu42/CQUThesis).
Write in English or Chinese is needed. Thank you.

# About the Author
Zhennan Li (i at nanmu dot me) proudly presents this work for you.

# License
This whole project may be distributed and/or modified under the conditions of the LaTeX Project Public License, either version 1.3 of this license or (at your option) any later version. The latest version of this license is in: 

http://www.latex-project.org/lppl.txt

and version 1.3 or later is part of all distributions of LaTeX version 2005/12/01 or later.