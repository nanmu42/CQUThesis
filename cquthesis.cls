%%
%% This is file `cquthesis.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% cquthesis.dtx  (with options: `cls')
%% 
%% This is a generated file.
%% 
%% Copyright (C) 2016-2016 by Zhennan Li <i@nanmu.me>
%% This file may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either
%% version 1.3 of this license or (at your option) any later
%% version. The latest version of this license is in:
%% 
%% http://www.latex-project.org/lppl.txt
%% 
%% and version 1.3 or later is part of all distributions of
%% LaTeX version 2005/12/01 or later.
%% 
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{cquthesis}
[2016/06/09 v0.9.7 Chongqing University Thesis Template]
\hyphenation{Cqu-Thesis}
\newcommand{\cquthesis}{\textsc{CquThesis}}
\def\version{0.9.7}
\RequirePackage{kvoptions}
\SetupKeyvalOptions{
family=cqu,
prefix=cqu@,
setkeys=\kvsetkeys}
\newif\ifcqu@bachelor
\newif\ifcqu@master
\newif\ifcqu@doctor
\cqu@bachelorfalse\cqu@masterfalse\cqu@doctorfalse
\define@key{cqu}{type}{%
\expandafter\csname cqu@#1true\endcsname}
\DeclareBoolOption{liberalformat}
\DeclareBoolOption[true]{academic}
\DeclareComplementaryOption{proffesionalmaster}{academic}
\DeclareBoolOption[true]{openany}
\DeclareComplementaryOption{openright}{openany}
\DeclareBoolOption[false]{abstractopenright}
\newif\if@onesideprint
\newif\if@twosideprint
\newif\if@autoprint
\@onesideprintfalse\@twosideprintfalse\@autoprintfalse
\define@key{cqu}{printmode}{%
\expandafter\csname @#1printtrue\endcsname}
\DeclareBoolOption[false]{secret}
\DeclareBoolOption[false]{seriftoc}
\DeclareBoolOption{continuoustoc}
\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{ctexbook}}
\kvsetkeys{cqu}{}
\ProcessKeyvalOptions*
\PassOptionsToPackage{no-math}{fontspec}
\ifcqu@openany
\LoadClass[openany,a4paper,oneside,UTF8,zihao=-4,scheme=plain,linespread=1.39,space=auto]{ctexbook}
\else
\LoadClass[openright,a4paper,oneside,UTF8,zihao=-4,scheme=plain,linespread=1.39,space=auto]{ctexbook}
\fi
\ifcqu@bachelor\relax\else
\ifcqu@master\relax\else
\ifcqu@doctor\relax\else
\ClassError{cquthesis}%
{Specified thesis type is obligatory: \MessageBreak
type=[bachelor|master|doctor]}{}
\fi
\fi
\fi
\if@autoprint\relax\else
\if@onesideprint\relax\else
\if@twosideprint\relax\else
\ClassWarning{cquthesis}%
{Unexpected or missing print mode, processing with AUTO: \MessageBreak
printmode=[oneside|twoside|auto]}{}
\@autoprinttrue
\fi
\fi
\fi
\RequirePackage{etoolbox}
\RequirePackage{xparse}
\RequirePackage{environ}
\RequirePackage{calc}
\RequirePackage{ifxetex}
\RequirePackage{fontspec}
\RequirePackage{amsmath}
\RequirePackage[defaultsups]{newtxtext}
\RequirePackage{newtxmath}
\RequirePackage{pifont}
\RequirePackage{CJKfntef}
\RequirePackage[labelformat=simple]{subcaption}
\RequirePackage{array}
\RequirePackage{tabularx}
\RequirePackage{booktabs}
\RequirePackage{longtable}
\RequirePackage{multirow}
\RequirePackage{diagbox}
\RequirePackage{tabu}
\RequirePackage{courier}
\RequirePackage{graphicx}
\RequirePackage{pdfpages}
\RequirePackage[shortlabels,inline]{enumitem}
\RequirePackage[amsmath,thmmarks,hyperref]{ntheorem}
\RequirePackage{changepage}
\RequirePackage{afterpage}
\RequirePackage[bottom,perpage,hang,symbol*]{footmisc}
\raggedbottom
\RequirePackage{varwidth}
\RequirePackage{xcolor}
\RequirePackage{metalogo}
\RequirePackage{xspace}
\RequirePackage[numbers,square,comma,super,sort&compress]{natbib}
\patchcmd{\@chapter}{\addtocontents{lof}{\protect\addvspace{10\p@}}}{}{}{} % lof
\patchcmd{\@chapter}{\addtocontents{lot}{\protect\addvspace{10\p@}}}{}{}{} % lot
\RequirePackage[hyperfootnotes=false,]{hyperref}
\hypersetup{%
linktoc=all,
bookmarksnumbered=true,
bookmarksopen=true,
bookmarksopenlevel=1,
breaklinks=true,
colorlinks=false,
plainpages=false,
pdfborder=0 0 0}
\urlstyle{same}
\ifxetex
\def\CJK@null{\kern\CJKnullspace\Unicode{48}{7}\kern\CJKnullspace}
\defaultfontfeatures{Mapping=tex-text}
\fi
\RequirePackage{tocloft}
\ifxetex
\hypersetup{%
CJKbookmarks=true}
\else
\hypersetup{%
unicode=true,
CJKbookmarks=false}
\fi
\let\cqu@cleardoublepage\cleardoublepage
\renewcommand{\cleardoublepage}{%
\clearpage{\pagestyle{style@empty}\cqu@cleardoublepage}
}%\cleardoublepage
\newcommand\cqu@addblankpage{%
\afterpage{%
{\null\pagestyle{style@empty}\clearpage}}}
\newif\if@backmatter
\renewcommand{\frontmatter}{%
\@backmatterfalse
\cleardoublepage
\pagenumbering{Roman}
\pagestyle{style@normal}
\ctexset{chapter/numbering = false,}
}
\renewcommand{\mainmatter}{%
\@backmatterfalse
\cleardoublepage
\pagenumbering{arabic}
\pagestyle{style@normal}
\ctexset{chapter/numbering = true,}
}
\renewcommand{\backmatter}{%
\@backmattertrue
\cleardoublepage
\ctexset{chapter/numbering = false,
section/number  = \Alph{section},
section/name  = {,.},
subsection/number = \CTEXthesection{}\arabic{subsection},}%
\setcounter{chapter}{0}
}
\RequirePackage{geometry}
\geometry{
a4paper, ignoreall, nomarginpar,
inner=25mm, outer=25mm, top=30mm, bottom=25mm,
bindingoffset=10mm, head=16mm, headsep=5mm, foot=15mm, footnotesep=5mm}
\RequirePackage{totcount}
\regtotcounter[auxfile=maxpage.aux]{page}
\if@autoprint
\ifcqu@bachelor
\ifnum\totvalue{page}>70 \@twosideprinttrue\else\@onesideprinttrue\fi
\else
\ifnum \totvalue{page}>60 \@twosideprinttrue\else\@onesideprinttrue\fi
\fi
\fi
\if@onesideprint
\ClassWarning{cquthesis}{Printing under oneside mode.}{}
\else
\if@twosideprint
\geometry{twoside}
\ClassWarning{cquthesis}{Printing under twoside mode.}{}
\fi
\fi
\RequirePackage{fancyhdr}
\fancypagestyle{style@empty}{%
\fancyhf{}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}}
\fancypagestyle{style@fixhead}{%
\fancyhead{}
\fancyhead[C]{\zihao{-5}\songti\leftmark}
\fancyfoot{}
\fancyfoot[C]{\zihao{-5}\thepage}
\renewcommand{\headrulewidth}{0.4pt}
\renewcommand{\footrulewidth}{0pt}}
\fancypagestyle{style@normal}{%
\fancyhead{}
\if@twosideprint
\fancyhead[EC]{\zihao{-5}\songti\cqu@thesisname}
\fancyhead[OC]{\zihao{-5}\songti\leftmark}
\else
\fancyhead[L]{\zihao{-5}\songti\cqu@thesisname}
\fancyhead[R]{\zihao{-5}\songti\leftmark}
\fi
\fancyfoot{}
\fancyfoot[C]{\zihao{-5}\thepage}
\renewcommand{\headrulewidth}{0.4pt}
\renewcommand{\footrulewidth}{0pt}}
\newcommand{\cqu@fixhead}{%
\if@twosideprint %仅双页打印需要修正
\checkoddpage
\ifoddpage\relax\else
\thispagestyle{style@fixhead}
\fi
\fi
}%\cqu@fixhead
\AtBeginDocument{%
\pagestyle{style@empty}
\renewcommand{\chaptermark}[1]{%
\ifnum\value{chapter}>0%
\@mkboth{\CTEXthechapter\hskip\ccwd#1}{}%
\else
\@mkboth{#1}{}%
\fi}}%\chaptermark
\let\@afterindentfalse\@afterindenttrue
\@afterindenttrue
\setlength{\parskip}{0.1\baselineskip}
\ctexset{%
punct=quanjiao,
autoindent=true,
space=auto}
\setlist{
nosep,
itemjoin = {{；}}
}%setlist
\def\@circlenum#1{%
\ifnum \value{#1} >10
\ClassError{cquthesis}%
{More than 10 subsubsections in a subsection cannot be handled.}{}
\fi
\ding{\the\numexpr\value{#1}+171\relax}%
}
\def\footnoterule{\vskip-3\p@\hrule\@width0.3\textwidth\@height0.4\p@\vskip2.6\p@}
\let\cqu@footnotesize\footnotesize
\renewcommand{\footnotesize}{\cqu@footnotesize\zihao{-5}}
\footnotemargin1.5em\relax
\let\cqu@makefnmark\@makefnmark
\def\cqu@@makefnmark{\mbox{{\normalfont\@thefnmark}}}
\pretocmd{\@makefntext}{\let\@makefnmark\cqu@@makefnmark}{}{}
\apptocmd{\@makefntext}{\let\@makefnmark\cqu@makefnmark}{}{}
\allowdisplaybreaks[4]
\let\cqu@tagform@\tagform@
\renewcommand{\eqref}[1]{\cqueqshortname\textup{(\ref{#1})}}
\theorembodyfont{\rmfamily\songti}
\theoremheaderfont{\rmfamily\heiti}
\RequirePackage[version=4]{mhchem}
\AtBeginDocument{\pretocmd{\ce}{{ }}{}{}}
\newcommand{\cec}[1]{\cesplit{{\,\ }{\0}}{#1}}
\RequirePackage{siunitx}
\RequirePackage{upgreek}
\ifxetex
\sisetup{%
math-micro = {\upmu},
text-micro = {\textmu},
}%\sisetup
\fi
\setlength{\floatsep}{20bp \@plus4pt \@minus1pt}
\setlength{\intextsep}{24bp \@plus4pt \@minus2pt}
\setlength{\textfloatsep}{20bp \@plus4pt \@minus2pt}
\setlength{\@fptop}{0bp \@plus1.0fil}
\setlength{\@fpsep}{12bp \@plus2.0fil}
\setlength{\@fpbot}{0bp \@plus1.0fil}
\renewcommand{\textfraction}{0.15}
\renewcommand{\topfraction}{0.85}
\renewcommand{\bottomfraction}{0.65}
\renewcommand{\floatpagefraction}{0.60}
\AtBeginDocument{%
\renewcommand{\thefigure}{%
\if@backmatter
\CTEXthesection \@arabic \c@figure
\else
\ifnum \c@chapter >\z@ \thechapter .\fi \@arabic \c@figure
\fi}
\renewcommand{\thetable}{%
\if@backmatter
\CTEXthesection \@arabic \c@table
\else
\ifnum \c@chapter >\z@ \thechapter .\fi \@arabic \c@table
\fi}
\renewcommand{\theequation}{%
\if@backmatter
\CTEXthesection \@arabic \c@equation
\else
\ifnum \c@chapter >\z@ \thechapter .\fi \@arabic \c@equation
\fi}
}
\def\cqu@tabular{\zihao{5}\@tabular}
\DeclareCaptionLabelFormat{cqu}{{\zihao{5}\songti #1~\rmfamily #2}}
\DeclareCaptionLabelSeparator{cqu}{\hspace{\ccwd}}
\DeclareCaptionFont{cqu}{\zihao{5}}
\captionsetup{labelformat=cqu,labelsep=cqu,font=cqu}
\captionsetup[table]{position=top,belowskip={12bp-\intextsep},aboveskip=6bp}
\captionsetup[figure]{position=bottom,belowskip={12bp-\intextsep},aboveskip=6bp}
\captionsetup[sub]{font=cqu,skip=6bp}
\renewcommand{\thesubfigure}{(\alph{subfigure})}
\renewcommand{\thesubtable}{(\alph{subtable})}
\AtBeginEnvironment{tabularx}{\begingroup\zihao{5}}
\AtEndEnvironment{tabularx}{\endgroup}
\setlength{\tabcolsep}{12pt}
\renewcommand{\tabularxcolumn}[1]{m{#1}}
\newcommand{\bigcell}[1]{\vspace{6pt}\begin{varwidth}{\linewidth}#1\end{varwidth}\vspace{6pt}}
\newcommand{\headcell}[1]{\multicolumn{1}{c}{\heiti #1}}
\newcommand{\colsep}[1][12pt]{\setlength{\tabcolsep}{#1}}
\let\cqu@LT@array\LT@array
\def\LT@array{\zihao{5}\cqu@LT@array}
\RequirePackage{listings}
\lstdefinestyle{lstStyleBase}{%
basicstyle=\scriptsize\ttfamily,
aboveskip=\medskipamount,
belowskip=\medskipamount,
lineskip=0pt,
boxpos=c,
showlines=false,
extendedchars=true,
upquote=true,
tabsize=2,
showtabs=false,
showspaces=false,
showstringspaces=false,
numbers=left,
numberstyle=\tiny,
linewidth=\linewidth,
xleftmargin=4pt,
xrightmargin=0pt,
resetmargins=false,
breaklines=true,
breakatwhitespace=false,
breakindent=0pt,
breakautoindent=true,
columns=flexible,
keepspaces=true,
framesep=3pt,
rulesep=2pt,
framerule=1pt,
backgroundcolor=\color{gray!5},
stringstyle=\color{green!40!black!100},
keywordstyle=\bfseries\color{blue!50!black},
commentstyle=\slshape\color{black!60}}
\lstdefinestyle{lstStyleCplus}{%
style=lstStyleBase,
frame=l,
rulecolor=\color{blue},
language=C++}
\lstdefinestyle{lstStylePython}{%
style=lstStyleBase,
frame=l,
rulecolor=\color{cyan},
language=Python}
\lstnewenvironment{Cplus}{\lstset{style=lstStylePython}}{}
\lstnewenvironment{Python}{\lstset{style=lstStyleCplus}}{}
\newcounter{cquXuHao}
\newcounter{cquXuHaoType}
\setcounter{cquXuHaoType}{1}
\newcommand{\xuhaoseparator}{}
\newcommand{\xuhaotype}[1][1]{
\ifnum #1>6 \ClassError{cquthesis}%
{Available choices from 1-6.}{}%
\fi
\setcounter{cquXuHaoType}{#1}
}%\xuhaotype
\newcommand{\output@xuhao}{%
\ifcase\value{cquXuHaoType}
\or \arabic{cquXuHao} %1
\or \Alph{cquXuHao} %2
\or \alph{cquXuHao} %3
\or \Roman{cquXuHao} %4
\or \roman{cquXuHao} %5
\or \ifnum\value{cquXuHao}>9\ClassError{cquthesis}%
{Xuhao(rownum) of type-6 must be under 10.}{}%
\else\fnsymbol{cquXuHao}
\fi %6
\fi
}%\output@xuhao
\newcommand{\xuhao}[1][0]{
\ifcase #1
\stepcounter{cquXuHao} %0
\output@xuhao\xuhaoseparator\xspace
\or \resetxuhao\stepcounter{cquXuHao} %1
\output@xuhao\xuhaoseparator\xspace
\fi
}%\xuhao
\newcommand{\resetxuhao}{\setcounter{cquXuHao}{0}}
\let\rownum\xuhao
\let\resetrownum\resetxuhao
\let\rownumtype\xuhaotype
\let\setxuhao\xuhaotype
\let\rownumseparator\xuhaoseparator
\def\cqu@def@term #1{%
\define@key{cqu}{#1}{\csname #1\endcsname{##1}}
\expandafter\gdef\csname #1\endcsname##1{%
\expandafter\gdef\csname cqu@#1\endcsname{##1}}
\csname #1\endcsname{}}
\cqu@def@term{ctitle}
\cqu@def@term{etitle}
\cqu@def@term{cauthor}
\cqu@def@term{eauthor}
\cqu@def@term{studentid}
\cqu@def@term{csupervisor}
\cqu@def@term{esupervisor}
\cqu@def@term{cpsupervisor}
\cqu@def@term{epsupervisor}
\cqu@def@term{cmajor}
\cqu@def@term{emajor}
\cqu@def@term{cclass}
\cqu@def@term{edgree}
\cqu@def@term{cdepartment}
\cqu@def@term{edepartment}
\cqu@def@term{mycdate}
\cqu@def@term{myedate}
\def\cqu@parse@keywords#1{
\define@key{cqu}{#1}{\csname #1\endcsname{##1}}
\expandafter\gdef\csname cqu@#1\endcsname{}
\expandafter\gdef\csname #1\endcsname##1{
\@for\reserved@a:=##1\do{
\expandafter\ifx\csname cqu@#1\endcsname\@empty\else
\expandafter\g@addto@macro\csname cqu@#1\endcsname{%
\ignorespaces\csname cqu@#1@separator\endcsname}
\fi
\expandafter\expandafter\expandafter\g@addto@macro%
\expandafter\csname cqu@#1\expandafter\endcsname\expandafter{\reserved@a}}}}
\cqu@parse@keywords{ckeywords}
\cqu@parse@keywords{ekeywords}
\def\cqusetup{\kvsetkeys{cqu}}
\newcommand{\make@cover@CN}{%
\thispagestyle{style@empty}
\begin{center}
\rule{0mm}{15mm}
\heiti
\ifcqu@bachelor
\zihao{-2}\cqu@thesistypenameCN
\\ \vspace{\stretch{1}}
\zihao{2}\cqu@ctitle
\\ \vspace{\stretch{2}}
\includegraphics[width=6cm]{CQUbadge.pdf}
\\ \vspace{\stretch{2}}
\else
\zihao{2}\cqu@ctitle
\\ \vspace{\stretch{1}}
\includegraphics[width=6cm]{CQUbadge.pdf}
\\ \vspace{\stretch{1}}
\zihao{-2}\cqu@thesistypenameCN
\ifcqu@master{}\\\cqu@mastertype\fi
\\ \vspace{\stretch{2}}
\fi
\ifcqu@bachelor
\zihao{3}
\begin{varwidth}{\textwidth}
\begin{CJKfilltwosides}{4.5\ccwd}
\cqu@studentCN\cqu@title@separatorCN\\
\cqu@studentnumCN\cqu@title@separatorCN\\
\cqu@supervisorCN\cqu@title@separatorCN\\
\cqu@majorCN\cqu@title@separatorCN
\end{CJKfilltwosides}
\end{varwidth}
\else
\zihao{3}
\begin{varwidth}{\textwidth}
\begin{CJKfilltwosides}{4.5\ccwd}
\cqu@studentCN\cqu@title@separatorCN\\
\cqu@supervisorCN\cqu@title@separatorCN\\
\ifcqu@academic
\cqu@majorCN\cqu@title@separatorCN\\
\else
\cqu@psupervisorCN\cqu@title@separatorCN\\
\fi
\cqu@majorclassCN\cqu@title@separatorCN
\end{CJKfilltwosides}
\end{varwidth}
\fi
\hskip.5\ccwd
\zihao{3}
\begin{varwidth}{\textwidth}%
\mbox{\cqu@cauthor}\\
\ifcqu@bachelor\mbox{\cqu@studentid}\\\fi
\cqu@csupervisor\\ %不要放在盒子里
\ifcqu@academic %这里有点复杂
\mbox{\cqu@cmajor}
\ifcqu@bachelor\relax\else\\\cqu@cclass\fi
\else
\cqu@cpsupervisor\\
\cqu@cclass
\fi
\end{varwidth}
\\ \vspace{\stretch{2}}
\zihao{-2}\cqu@universitynameCN\cqu@cdepartment\\[1mm]
\zihao{3}\ifdefempty{\cqu@mycdate}{\cdate}{\cqu@mycdate}
\vspace{10mm}
\end{center}}
\newcommand{\make@cover@EN}{%
\cleardoublepage
\thispagestyle{style@empty}
\begin{center}
\rule{0mm}{15mm}
\sffamily
\ifcqu@bachelor
\zihao{-2}\cqu@thesistypenameEN
\\ \vspace{\stretch{2}}
\zihao{-1}\textbf{\cqu@etitle}
\\ \vspace{\stretch{1}}
\includegraphics[width=5cm]{CQUbadge.pdf}
\\ \vspace{\stretch{2}}
\zihao{3}\textbf{\cqu@studentEN\cqu@title@separatorEN\mbox{\cqu@eauthor}}\\
\cqu@supervisorEN\cqu@title@separatorEN\mbox{\cqu@esupervisor}\\
\cqu@majorEN\cqu@title@separatorEN\mbox{\cqu@emajor}
\else
\zihao{-1}\textbf{\cqu@etitle}
\\ \vspace{\stretch{2}}
\includegraphics[width=5cm]{CQUbadge.pdf}
\\ \vspace{\stretch{2}}
\zihao{3}\cqu@thesistypenameEN
\\[1mm]
\cqu@workby
\\[2mm]
\zihao{3}\mbox{\textbf{\cqu@eauthor}}
\\ \vspace{\stretch{1}}
\textbf{\cqu@supervisorEN\cqu@title@separatorEN}\textbf{\cqu@esupervisor}\\
\ifcqu@academic\relax\else\textbf{\cqu@psupervisorEN\cqu@title@separatorEN\cqu@epsupervisor}\\\fi
\textbf{\cqu@majorEN\cqu@title@separatorEN}\mbox{\textbf{\cqu@emajor}}
\fi
\\ \vspace{\stretch{2}}
\zihao{-2}\cqu@edepartment\\\cqu@universitynameEN\\[1mm]
\ifdefempty{\cqu@myedate}{\textbf{\edate}}{\textbf{\cqu@myedate}}
\vspace{10mm}
\end{center}}
\def\makecover{%
\hypersetup{%
pdftitle = {\cqu@ctitle},
pdfauthor = {\cqu@cauthor},
pdfsubject = {\cqu@thesistypenameCN},
pdfkeywords = {\cqu@ckeywords},
pdfcreator = {CQUThesis--v\version, a LaTeX template.}
}
\phantomsection
\pdfbookmark[-1]{\cqu@ctitle}{ctitle}
\make@cover@CN
\make@cover@EN
}%makecover
\newcommand{\cqu@@cabstract}[1]{\long\gdef\cqu@cabstract{#1}}
\newenvironment{cabstract}{\Collect@Body\cqu@@cabstract}{}
\newcommand{\cqu@@eabstract}[1]{\long\gdef\cqu@eabstract{#1}}
\newenvironment{eabstract}{\Collect@Body\cqu@@eabstract}{}
\def\makeabstract{%
\cleardoublepage
\normalsize
\cqu@makeabstract
}%makeabstract
\newcommand{\cqu@makeabstract}{%
\clearpage
\chapter[\cqu@cabstract@tocname]{\cqu@cabstract@name}
\pagestyle{style@normal}
\cqu@fixhead
\pagenumbering{Roman}
\cqu@cabstract
\vskip12bp
\cqu@put@kw{\heiti\cqu@ckw@title\cqu@title@separatorCN}{\cqu@ckeywords}
\if@twosideprint\ifcqu@openany\ifcqu@abstractopenright\cqu@addblankpage\fi\fi\fi
\chapter[\cqu@eabstract@tocname]{\sffamily\textbf{\cqu@eabstract@name}}
\cqu@fixhead
\cqu@eabstract
\vskip12bp
\cqu@put@kw{\textbf{\cqu@ekw@title\cqu@title@separatorEN}}{\cqu@ekeywords}
}
\newbox\cqu@kw
\newcommand{\cqu@put@kw}[2]{%
\begingroup
\setbox\cqu@kw=\hbox{#1}
\noindent\hangindent\wd\cqu@kw\hangafter1
\box\cqu@kw#2\par
\endgroup}
\NewDocumentCommand{\cqu@makeauth}{o}{%
\clearpage
\thispagestyle{style@empty}
\IfNoValueTF{#1}{%
\rule{0mm}{5mm}
\begin{center}
\zihao{3}
\begin{CJKfilltwosides}{6\ccwd}
\heiti{}\cqu@innotitle
\end{CJKfilltwosides}
\end{center}
\vspace{2mm}
\zihao{-4}
\par\cqu@innobody
\\[5mm]
\par\cqu@innosignature\hfill\cqu@signdate
\vspace{15mm}
\begin{center}
\zihao{3}\heiti
\cqu@authtitle
\end{center}
\vspace{2mm}
\zihao{-4}
\par\cqu@authbody
\\[15mm]
\begin{minipage}{\textwidth}
\begin{minipage}{15\ccwd}
\cqu@authsignaturestu\\[10mm]
\cqu@signdate
\end{minipage}
\hfill
\begin{minipage}{15\ccwd}
\cqu@authsignaturesup\\[10mm]
\cqu@signdate
\end{minipage}
\end{minipage}
}{
\includepdf{#1}
}
}%\cqu@makeauth
\let\cquauthpage\cqu@makeauth
\newlist{cqu@denotation}{description}{1}
\setlist[cqu@denotation]{%
nosep,
font = \normalfont,
align = left,
leftmargin = !,
labelindent = 0mm,
labelwidth = 25mm,
labelsep* = 5mm,
itemindent = 0mm,
}%\setlist
\NewDocumentEnvironment{denotation}{O{20mm} O{30mm}}{%
\chapter*{\cqu@denotation@name}
\chaptermark{\cqu@denotation@name}\cqu@fixhead
\zihao{-4}\begin{cqu@denotation}[labelindent = #1,labelwidth=#2,]
}{
\end{cqu@denotation}}%\denotation
\setcounter{tocdepth}{2}
\setcounter{secnumdepth}{3}
\setlength{\cftbeforechapskip}{1mm}
\ifcqu@liberalformat
\cftsetindents{chapter}{0em}{1.5em}
\cftsetindents{section}{1.9em}{0.9em}
\cftsetindents{subsection}{4.0em}{1.5em}
\else
\cftsetindents{chapter}{0em}{1.5em}
\cftsetindents{section}{1.5em}{2.2em}
\cftsetindents{subsection}{3.7em}{2.9em}
\fi
\ifcqu@seriftoc
\renewcommand{\cftchapleader}{\cftdotfill{\cftdotsep}}
\renewcommand{\cftchapfont}{\zihao{4}\sffamily\heiti}
\renewcommand{\cftsecfont}{\zihao{5}\sffamily\heiti}
\renewcommand{\cftsubsecfont}{\zihao{5}}
\fi
\newlistof[chapter]{equations}{equ}{\listofequationsname}
\newcommand{\listeq}[1]{%
\addcontentsline{equ}{equations}{\protect\numberline{\theequation}#1}\par}
\setlength{\cftequationsnumwidth}{2.5em}
\let\eqlist\listeq
\tocloftpagestyle{style@normal}
\renewcommand{\cfttoctitlefont}{%
\phantomsection\pdfbookmark[0]{\cqu@tocnameinbkmark}{toc}\cqu@fixhead\hfill\heiti\zihao{3}}
\renewcommand{\cftloftitlefont}{\cqu@fixhead\hfill\heiti\zihao{3}}
\renewcommand{\cftlottitlefont}{\cqu@fixhead\hfill\heiti\zihao{3}}
\renewcommand{\cftequtitlefont}{\cqu@fixhead\hfill\heiti\zihao{3}}
\renewcommand{\cftaftertoctitle}{\hfill}
\renewcommand{\cftafterloftitle}{\hfill}
\renewcommand{\cftafterlottitle}{\hfill}
\renewcommand{\cftafterequtitle}{\hfill}
\ifcqu@continuoustoc\relax\else
\renewcommand{\@cfttocstart}{\clearpage}
\renewcommand{\@cfttocfinish}{\clearpage}
\fi
\newcommand{\chapterstar}[1]{%
\chapter*{#1}%
\phantomsection
\@mkboth{#1}{}
\addcontentsline{toc}{chapter}{#1}}
\bibpunct{[}{]}{,}{s}{}{,}
\renewcommand\NAT@citesuper[3]{\ifNAT@swa%
\unskip\kern\p@\textsuperscript{\NAT@@open #1\NAT@@close}%
\if*#3*\else\ (#3)\fi\else #1\fi\endgroup}
\DeclareRobustCommand\inlinecite{\@inlinecite}
\def\@inlinecite#1{\begingroup\let\@cite\NAT@citenum\citep{#1}\endgroup}
\let\onlinecite\inlinecite
\pretocmd{\bibliography}{%
\clearpage\phantomsection\addcontentsline{toc}{chapter}{\cqu@bib@name}}{}{}
\AtBeginDocument{%
\pretocmd{\bibliography}{\begingroup\zihao{5}}{}{}
\apptocmd{\bibliography}{\endgroup}{}{}
}%AtBeginDocument
\renewcommand\@biblabel[1]{\zihao{5}[#1]}
\renewenvironment{thebibliography}[1]
{\chapter*{\cqu@bib@name
\@mkboth{\cqu@bib@name}{}}%
\list{\@biblabel{\@arabic\c@enumiv}}%
{\settowidth\labelwidth{\@biblabel{#1}}%
\leftmargin\labelwidth
\advance\leftmargin\labelsep
\setlength{\parsep}{1mm}
\setlength{\labelsep}{0.5em}
\setlength{\itemsep}{0.05pc}
\setlength{\listparindent}{0in}
\setlength{\itemindent}{0in}
\setlength{\rightmargin}{0in}
\@openbib@code
\usecounter{enumiv}%
\let\p@enumiv\@empty
\renewcommand\theenumiv{\@arabic\c@enumiv}}%
\sloppy
\clubpenalty4000
\@clubpenalty\clubpenalty
\widowpenalty4000%
\sfcode`\.\@m
}{%
\def\@noitemerr
{\@latex@warning{Empty `thebibliography' environment}}%
\endlist \vskip.2in}
\AtEndOfClass{\input{cquthesis.cfg}}
\endinput
%%
%% End of file `cquthesis.cls'.
