@echo off


cd /d "%~dp0" 

title CQUThesis Build Helper

set flag=%1
if %flag%x == x (
  set flag=thesis
)

if %flag%x == thesisx (
  call:thesis
  goto :EOF
)
if %flag%x == thesisxx (
  call:thesisx
  goto :EOF
)
if %flag%x == docx (
  call:extract
  call:document
  goto :EOF
)
if %flag%x == cleanx (
  call:cleanaux
  goto :EOF
)
if %flag%x == cleanpdfx (
  call:cleanpdf
  goto :EOF
)
if %flag%x == cleanallx (
  call:cleanaux
  call:cleanpdf
  goto :EOF
)
if %flag%x == extractx (
  call:extract
  goto :EOF
)
if %flag%x == allx (
  call:thesis
  call:document
  goto :EOF
)
if %flag%x == buildx (
  call:extract
  call:thesis
  goto :EOF
)
if %flag%x == buildxx (
  call:extract
  call:thesis
  call:document
  goto :EOF
)

:help
  echo *************************************************************
  echo This is the Makefile script for CQUThesis on Windows.
  echo For CQUThesis: https://github.com/nanmu42/CQUThesis
  echo by Zhennan Li (C) 2016 under LPPL 1.3
  echo The idea comes from Github Liam0205/sduthesis, Many thanks!
  echo *************************************************************
  echo *
  echo USAGE:
  echo        makewin [param]
  echo param:
  echo   help      Display this help text
  echo   thesis    (default)Compile the thesis via latexmk
  echo   thesisx   Compile the thesis via XeLaTeX(only if latexmk is not installed.)
  echo   doc       Compile the documentation of CQUThesis
  echo   clean     Clean all aux files
  echo   cleanpdf  Clean all PDFs
  echo   cleanall  Clean all aux files and all PDFs
  echo   extract   Extract the Thesis Template from .dtx files.
  echo   all       thesis + doc
  echo   build     extract + thesis
  echo   buildx    extract + thesis + doc
  echo *
  echo ***********************Happy TeXing**************************
goto :EOF

:checkfiles
  IF NOT EXIST cquthesis.cls call:extract
  IF NOT EXIST cquthesis.cfg call:extract
goto :EOF

:thesis
  call:checkfiles
  latexmk -xelatex main.tex
goto :EOF

:thesisx
  call:checkfiles
  xelatex main.tex
  bibtex main.tex
  xelatex main.tex
  xelatex main.tex
  xelatex main.tex
goto :EOF

:cleanaux
  echo cleaning aux...
  for %%i in (*.aux *.bbl *.equ *.glo *.gls *.hd *.idx *.ilg *.ind *.lof *.lot *.out *.blg *.log *.thm *.toc *.synctex.gz *.lofEN *.lotEN *.equEN) do (
    del %%i
  )
  echo Done.
goto :EOF

:cleanpdf
  echo cleaning pdf...
  for %%i in (*.pdf) do (
    del %%i
  )
  echo Done.
goto :EOF

:clean_all
  call:cleanaux
  call:cleanpdf
goto :EOF

:extract
  echo extracting...
  latex cquthesis.ins
  echo *******CQUThesis has been extracted.********
goto :EOF

:document
  echo building documents...
  set cmode=-interaction=batchmode
  xelatex cquthesis.dtx
  makeindex -s gind.ist -o cquthesis.ind cquthesis.idx
  makeindex -s gglo.ist -o cquthesis.gls cquthesis.glo
  xelatex cquthesis.dtx
  xelatex cquthesis.dtx
  xelatex cquthesis.dtx
goto :EOF
