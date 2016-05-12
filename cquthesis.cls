\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{cquthesis}[2016/05/10 0.5.2 Chongqing University Thesis Template]

% -----开发用常量------
\hyphenation{Cqu-Thesis}
\newcommand{\cquthesis}{\textsc{CquThesis}}
\def\version{0.5.2}

% ----- DECLARATION OF OPTIONS ------
% 使用Key=Value方式进行选项设置，定义前缀和族
% 下面定义各个选项：
\RequirePackage{kvoptions}
\SetupKeyvalOptions{
	family=cqu,
	prefix=cqu@,
	setkeys=\kvsetkeys}
% 定义用户类型
\newif\ifcqu@bachelor
\newif\ifcqu@master
\newif\ifcqu@doctor
\cqu@bachelorfalse\cqu@masterfalse\cqu@doctorfalse
\define@key{cqu}{type}{%
	\expandafter\csname cqu@#1true\endcsname}
% 定义是否使用本科文学类论文标题格式
\DeclareBoolOption{liberalformat}
% 专业硕士标记
\DeclareBoolOption[true]{academic}
\DeclareComplementaryOption{proffesionalmaster}{academic}
% DELETE:开发用
\newcommand{\showmaster}{\ifcqu@academic{}学硕\else{}专硕\fi}
% 论文是单面打印还是双面打印（默认：自动，手动模式一般不用）
\newif\if@onesideprint
\newif\if@twosideprint
\newif\if@autoprint
\@onesideprintfalse\@twosideprintfalse\@autoprintfalse
\define@key{cqu}{printmode}{%
	\expandafter\csname @#1printtrue\endcsname}
% 论文是否保密（默认：关）
% TODO：未支持，在计划中
\DeclareBoolOption{secret}
%	目录和索引不会自动新开一页，适用于索引内容较少时
\DeclareBoolOption{continuoustoc}
% 传递选项给CTEXBOOK
\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{ctexbook}}
% 打开默认选项
\kvsetkeys{cqu}{%
	}
\ProcessKeyvalOptions*
\PassOptionsToPackage{no-math}{fontspec}
% 为CtexBook定义选项
\LoadClass[a4paper,oneside,openany,UTF8,zihao=-4,scheme=plain,linespread=1.39,space=auto]{ctexbook}

% 用户必须提供用户类型
\ifcqu@bachelor\relax\else
	\ifcqu@master\relax\else
		\ifcqu@doctor\relax\else
			\ClassError{cquthesis}%
				{Specified thesis type is obligatory: \MessageBreak
					type=[bachelor|master|doctor]}{}
		\fi
	\fi
\fi
% 如果没有指定合适的打印方式则缺省使用自动模式
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

% ----- PACKAGE LOADING ------  
\RequirePackage{etoolbox}					%.cls工具
\RequirePackage{calc}
\RequirePackage{ifxetex}
\RequirePackage{amsmath}					%更好的数学公式支持
\RequirePackage{xparse}						%更好的命令定义
\RequirePackage[defaultsups]{newtxtext}		%英文字体支持
\RequirePackage{newtxmath}					%数学字体支持
\RequirePackage[labelformat=simple]{subcaption}
\RequirePackage{longtable}					%两个环境，用于解决caption定制、子caption和长表格
\RequirePackage{tgcursor}
\RequirePackage{graphicx}
\RequirePackage{pdfpages}					%pdfpages用于插入扫描的PDF文档
\RequirePackage[shortlabels,inline]{enumitem}		%中文更友好的列表环境
\RequirePackage{environ}					%提供另一种环境定义方式
\RequirePackage{changepage}				%用来修复双页打印模式时的索引页眉
\RequirePackage{afterpage}
\RequirePackage[bottom,perpage,hang]{footmisc}
\raggedbottom								%脚注控制，脚注每页重新编号
\RequirePackage{pifont}						%带圈数字，后面还需要处理
%定理宏包，兼容模式
\RequirePackage[amsmath,thmmarks,hyperref]{ntheorem}
%参考文献引用宏包
\RequirePackage[square,comma,super,sort&compress]{natbib}
\RequirePackage{hyperref}
\RequirePackage{CJKfntef}
\RequirePackage{pbox}					% 用来优化minipage宽度
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
%TODO: 提升：在hyperref之后在正文手动载入breakurl，处理dvips模式下的网址断字问题
% ----- MAIN CODE ------
% 定义清空页面（另开右页）功能和页面的三种形态
% 首页右开的时候，全空的左页不留页眉页脚
\let\cqu@cleardoublepage\cleardoublepage
\renewcommand{\cleardoublepage}{%
	\clearpage{\pagestyle{style@empty}\cqu@cleardoublepage}
}%\cleardoublepage

% 用来在单页模式下强制完成空页工作，
% 这里的pagestyle调整有些坑
\newcommand\cqu@addblankpage{%
	\afterpage{%
		\null\pagestyle{style@empty}\clearpage}}

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
					 section/number		 = \Alph{section},
					 section/name		 = {,.},
					 subsection/number = \CTEXthesection{}\arabic{subsection},}
}

% 定义页面，页眉页脚，先建立页面环境，完成分页再决定单双面打印
\RequirePackage{geometry}
\geometry{
	a4paper, ignoreall, nomarginpar,
	inner=25mm, outer=25mm, top=30mm, bottom=25mm,
	bindingoffset=10mm, head=16mm, headsep=5mm, foot=15mm, footnotesep=5mm}

% 重大的单双面打印和论文实际页数有关，此处读取最大页码，自动判断是否需要双面打印。
% TODO: Pageslts的统计结果似乎更准，目前手动刨除了前置部分的8页(估计值)
\usepackage{totcount}
\regtotcounter[auxfile=maxpage.aux]{page}
%\usetotcountfile{maxpage.aux}	%测试用
\if@autoprint
	\ifcqu@bachelor
		\ifnum\totvalue{page}>62 \@twosideprinttrue\else\@onesideprinttrue\fi	%很有趣，本科生70页想要双面打印比硕士生60页还难
	\else
		\ifnum \totvalue{page}>52 \@twosideprinttrue\else\@onesideprinttrue\fi %立flag用来配合\cqu@addblankpage
	\fi
\fi
% 决定单页/双页打印
\if@onesideprint\relax\else
	\if@twosideprint \geometry{twoside}\fi
\fi

% 定义页眉页脚
\RequirePackage{fancyhdr}

% 定制页眉页脚模式，全部以style@开头
% 1. 页眉页脚全空（用于标题页、主体部分另页右开等）
\fancypagestyle{style@empty}{%
	\fancyhf{}
	\renewcommand{\headrulewidth}{0pt}
	\renewcommand{\footrulewidth}{0pt}}
% 2. 用来修正双页打印时的页眉遮挡问题（右开的索引页眉不再是\cqu@thesisname）
\fancypagestyle{style@fixhead}{%
	\fancyhead{}
	\fancyhead[C]{\zihao{-5}\songti\leftmark}
	\fancyfoot{}
	\fancyfoot[C]{\zihao{-5}\thepage}
	\renewcommand{\headrulewidth}{0.4pt}
	\renewcommand{\footrulewidth}{0pt}}
% 3. 页眉页脚齐全（用于一般正文页面，这里自动判定用户类型和打印单双面）
\fancypagestyle{style@normal}{%
	\fancyhead{}
	\if@twosideprint
		\fancyhead[OC]{\zihao{-5}\songti\cqu@thesisname}
		\fancyhead[EC]{\zihao{-5}\songti\leftmark}
	\else
		\fancyhead[L]{\zihao{-5}\songti\cqu@thesisname}
		\fancyhead[R]{\zihao{-5}\songti\leftmark}
	\fi
	\fancyfoot{}
	\fancyfoot[C]{\zihao{-5}\thepage}
	\renewcommand{\headrulewidth}{0.4pt}
	\renewcommand{\footrulewidth}{0pt}}
% 修正页眉遮挡，这个命令要在标题生成的地方使用
\newcommand{\cqu@fixhead}{%
	\if@twosideprint	%仅双页打印需要修正
		\checkoddpage
		\ifoddpage
			\thispagestyle{style@fixhead}
		\fi
	\fi
}%\cqu@fixhead

% 修正fancyhdr的问题，同时让页眉不显示第0章的编号
\AtBeginDocument{%
	\pagestyle{style@empty}
	\renewcommand{\chaptermark}[1]{%
		\ifnum\value{chapter}>0%
			\@mkboth{\CTEXthechapter\hskip\ccwd#1}{}%
		\else
			\@mkboth{#1}{}%
		\fi}}%\chaptermark

% 段落
% LaTeX使用\if@afterindent来决定要不要让标题后的第一个自然段缩进，中文环境下好像并没有
% 个人喜好之类的问题，我们这里让它一直为True. 感谢indentfirst.
\let\@afterindentfalse\@afterindenttrue
\@afterindenttrue
% 每个自然段之间空1/10行距，增加可读性
\setlength{\parskip}{0.1\baselineskip}
% 全文首行缩进两字符，全角标点，去掉列表中项目之间的额外间隔（enumitem）
\ctexset{%
	punct=quanjiao,
	autoindent=true,
	space=auto}
\setlist{
	nosep,
	itemjoin = {{；}}
}%setlist

% 脚注
% 用带圈的数字作为脚注，由于字体限制，最多能在单页上处理10个脚注
\def\@circlenum#1{%
	\ifnum \value{#1} >10
		\ClassError{cquthesis}%
			{In a single page, Footnotes more than 10 are not supported.}
	\fi
	\ding{\numexpr171+ \value{#1}}%
}
% 注意这里\@circlenum要接受的是counter里的值，所以需要\value{}来处理，如果用数字直接做\@circlenum
% 的参数，要去掉\value才能编译通过
\renewcommand{\thefootnote}{\@circlenum{footnote}}
\renewcommand{\thempfootnote}{\@circlenum{mpfootnote}}
% 设置分割线、字号和悬挂缩进
\def\footnoterule{\vskip-3\p@\hrule\@width0.3\textwidth\@height0.4\p@\vskip2.6\p@}
\let\cqu@footnotesize\footnotesize
\renewcommand{\footnotesize}{\cqu@footnotesize\zihao{-5}}
\footnotemargin1.5em\relax
% 脚注部分将标注换为正文大小，这个过程是动态的
\let\cqu@makefnmark\@makefnmark
\def\cqu@@makefnmark{\hbox{{\normalfont\@thefnmark}}}
\pretocmd{\@makefntext}{\let\@makefnmark\cqu@@makefnmark}{}{}
\apptocmd{\@makefntext}{\let\@makefnmark\cqu@makefnmark}{}{}

% 数学相关
\allowdisplaybreaks[4]
%\patchcmd{\theequation}{.}{--}{}{}	 重大的式子标注为“式（3.2）”，这里记下这个经典的用法（但是不用）
\let\cqu@tagform@\tagform@
%\renewcommand{\tagform@}[1]{{式\cqu@tagform@{#1}}}
\renewcommand{\eqref}[1]{\cqueqshortname\textup{(\ref{#1})}}

% 定理环境相关
\theorembodyfont{\rmfamily\songti}
\theoremheaderfont{\rmfamily\heiti}
% 定理环境中文定义在.cfg中完成

% 浮动对象管理
% 设定浮动对象与文字的间距
\setlength{\floatsep}{20bp \@plus4pt \@minus1pt}
\setlength{\intextsep}{20bp \@plus4pt \@minus2pt}
\setlength{\textfloatsep}{20bp \@plus4pt \@minus2pt}
\setlength{\@fptop}{0bp \@plus1.0fil}
\setlength{\@fpsep}{12bp \@plus2.0fil}
\setlength{\@fpbot}{0bp \@plus1.0fil}

% 让浮动对象缺省值更宽松
\renewcommand{\textfraction}{0.15}
\renewcommand{\topfraction}{0.85}
\renewcommand{\bottomfraction}{0.65}
\renewcommand{\floatpagefraction}{0.60}

% 定制表格和插图的题注样式
\def\cqu@tabular{\zihao{5}\@tabular}
\DeclareCaptionLabelFormat{cqu}{{\zihao{5}\songti #1~\rmfamily #2}}
\DeclareCaptionLabelSeparator{cqu}{\hspace{\ccwd}}
\DeclareCaptionFont{cqu}{\zihao{5}}
\captionsetup{labelformat=cqu,labelsep=cqu,font=cqu}
% 两个skip设置都是正确的，已检测
\captionsetup[table]{position=top,belowskip={12bp-\intextsep},aboveskip=6bp}
\captionsetup[figure]{position=bottom,belowskip={12bp-\intextsep},aboveskip=6bp}
\captionsetup[sub]{font=cqu,skip=6bp}
\renewcommand{\thesubfigure}{(\alph{subfigure})}
\renewcommand{\thesubtable}{(\alph{subtable})}
% longtable方面也需要做设置
\let\cqu@LT@array\LT@array
\def\LT@array{\zihao{5}\cqu@LT@array}

% 封面
\def\cqu@def@term #1{%
	\define@key{cqu}{#1}{\csname #1\endcsname{##1}}
	\expandafter\gdef\csname #1\endcsname##1{%
		\expandafter\gdef\csname cqu@#1\endcsname{##1}}
	\csname #1\endcsname{}}

% 论文的中英文题目（封面第二行）
\cqu@def@term{ctitle}
\cqu@def@term{etitle}

% 作者部分的信息（校徽下方）
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

% 底部的学院名称和日期
\cqu@def@term{cdepartment}
\cqu@def@term{edepartment}
\cqu@def@term{cdate}
\cqu@def@term{edate}

%% 论文的中英文摘要
\newcommand{\cqu@@cabstract}[1]{\long\gdef\cqu@cabstract{#1}}
\newenvironment{cabstract}{\Collect@Body\cqu@@cabstract}{}
\newcommand{\cqu@@eabstract}[1]{\long\gdef\cqu@eabstract{#1}}
\newenvironment{eabstract}{\Collect@Body\cqu@@eabstract}{}

% 收集关键词并且做关键词分割
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

% 使用kvoptions提供key=value格式支持
\def\cqusetup{\kvsetkeys{cqu}}

%% 绘制中文封面
\newcommand{\make@cover@CN}{%
	\thispagestyle{style@empty}
	\begin{center}
		% 用来调整
		\rule{0mm}{15mm}
		\heiti
		\ifcqu@bachelor
			\zihao{-2}\cqu@thesistypenameCN
			\\	\vspace{\stretch{1}}
			\zihao{2}\cqu@ctitle
			\\	\vspace{\stretch{2}}
			\includegraphics[width=6cm]{CQUbandage.pdf}
			\\	\vspace{\stretch{2}}
		\else
			\zihao{2}\cqu@ctitle
			\\	\vspace{\stretch{1}}
			\includegraphics[width=6cm]{CQUbandage.pdf}
			\\	\vspace{\stretch{1}}
			\zihao{-2}\cqu@thesistypenameCN
			\ifcqu@master{}\\\cqu@mastertype\fi
			\\	\vspace{\stretch{2}}		
		\fi
		\ifcqu@bachelor
			\zihao{3}
			\begin{minipage}{4.5\ccwd}
				\begin{CJKfilltwosides}{4.5\ccwd}
					\cqu@studentCN\cqu@title@separatorCN\\
					\cqu@studentnumCN\cqu@title@separatorCN\\
					\cqu@supervisorCN\cqu@title@separatorCN\\
					\cqu@majorCN\cqu@title@separatorCN
				\end{CJKfilltwosides}
			\end{minipage}
		\else
			\zihao{3}
			\begin{minipage}{4.5\ccwd}
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
			\end{minipage}
		\fi
		% 不换行，左右并列
		\hskip.5\ccwd
		\zihao{3}
		\begin{minipage}%
			{\widthofpbox{\cqu@cauthor\\\cqu@studentid\\\cqu@cmajor\\\cqu@cclass\\\cqu@cpsupervisor}}%
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
		\end{minipage}
		\\	\vspace{\stretch{2}}
		\zihao{-2}\cqu@universitynameCN\cqu@cdepartment\\[1mm]
		\zihao{3}\cdate
		\vspace{10mm}
	\end{center}}

\newcommand{\make@cover@EN}{%
	\cleardoublepage
	\thispagestyle{style@empty}
	\begin{center}
		% 用来调整
		\rule{0mm}{15mm}
		\sffamily
		\ifcqu@bachelor
			% 本科生的封面
			\zihao{-2}\cqu@thesistypenameEN
			\\	\vspace{\stretch{2}}
			\zihao{-1}\textbf{\cqu@etitle}
			\\	\vspace{\stretch{1}}
			\includegraphics[width=5cm]{CQUbandage.pdf}
			\\	\vspace{\stretch{2}}
			\zihao{3}\textbf{\cqu@studentEN\cqu@title@separatorEN\mbox{\cqu@eauthor}}\\
			\cqu@supervisorEN\cqu@title@separatorEN\mbox{\cqu@esupervisor}\\
			\cqu@majorEN\cqu@title@separatorEN\mbox{\cqu@emajor}
		\else
			% 硕士生和博士生的高度相似
			\zihao{-1}\textbf{\cqu@etitle}
			\\	\vspace{\stretch{2}}
			\includegraphics[width=5cm]{CQUbandage.pdf}
			\\	\vspace{\stretch{2}}
			\zihao{3}\cqu@thesistypenameEN
			\\[1mm]
			\cqu@workby
			\\[2mm]
			\zihao{3}\mbox{\textbf{\cqu@eauthor}}
			\\	\vspace{\stretch{1}}
			\textbf{\cqu@supervisorEN\cqu@title@separatorEN}\textbf{\cqu@esupervisor}\\
			\ifcqu@academic\relax\else\textbf{\cqu@psupervisorEN\cqu@title@separatorEN\cqu@epsupervisor}\\\fi
			\textbf{\cqu@majorEN\cqu@title@separatorEN}\mbox{\textbf{\cqu@emajor}}
		\fi
		\\ \vspace{\stretch{2}}
		\zihao{-2}\cqu@edepartment\\\cqu@universitynameEN\\[1mm]
		\textbf{\edate}
		\vspace{10mm}
	\end{center}}

% 开发用
%\let\testbachelorCN\make@cover@CN
%\let\testbachelorEN\make@cover@EN

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
	\if@onesideprint\cqu@addblankpage\fi
	\make@cover@EN
	\if@onesideprint\cqu@addblankpage\fi
}%makecover
%% 生成摘要的命令
\def\makeabstract{%
	\cleardoublepage
	\normalsize
	\cqu@makeabstract
}%makeabstract
% 摘要
% 排版关键字
\newbox\cqu@kw
\newcommand{\cqu@put@kw}[2]{%
	\begingroup
	\setbox\cqu@kw=\hbox{#1}
	\noindent\hangindent\wd\cqu@kw\hangafter1
	\box\cqu@kw#2\par
	\endgroup}
% 中文摘要
\newcommand{\cqu@makeabstract}{%
	\clearpage
	\chapter[\cqu@cabstract@tocname]{\cqu@cabstract@name}
	\pagestyle{style@normal}
	\cqu@fixhead
	\pagenumbering{Roman}
	\cqu@cabstract
	\vskip12bp
	\cqu@put@kw{\heiti\cqu@ckw@title\cqu@title@separatorCN}{\cqu@ckeywords}
	\chapter[\cqu@eabstract@tocname]{\sffamily\textbf{\cqu@eabstract@name}}
	\cqu@fixhead
	\cqu@eabstract
	\vskip12bp
	\cqu@put@kw{\textbf{\cqu@ekw@title\cqu@title@separatorEN}}{\cqu@ekeywords}
	}
	
% 绘制独创性声明和授权书页面
\NewDocumentCommand{\cqu@makeauth}{o}{%
	\clearpage
	\thispagestyle{style@empty}
	\IfNoValueTF{#1}{%
		\rule{0mm}{5mm}
		\begin{center}
		\zihao{3}
		\begin{CJKfilltwosides}{6\ccwd}
			\heiti{}独创性声明
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
		学位论文版权使用授权书
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

% 主要符号对照表
\newlist{cqu@denotation}{description}{1}
\setlist[cqu@denotation]{%
	nosep,
	font	=	\normalfont,
	align	=	left,
	leftmargin	=	!,
	labelindent = 0mm,
	labelwidth	=	25mm,
	labelsep*		=	5mm,
	itemindent	=	0mm,
}%\setlist
\NewDocumentEnvironment{denotation}{O{20mm} O{30mm}}{%
	\chapter*{\cqu@denotation@name}
	\chaptermark{\cqu@denotation@name}\cqu@fixhead
	\zihao{-4}\begin{cqu@denotation}[labelindent = #1,labelwidth=#2,]
	}{
\end{cqu@denotation}}%\denotation

%% 设置目录
% 公式索引
\newlistof[chapter]{equations}{equ}{\listofequationsname}
\newcommand{\listeq}[1]{%
	\addcontentsline{equ}{equations}{\protect\numberline{\theequation}#1}\par}
\setlength{\cftequationsnumwidth}{2.5em}
% 正确输出页眉页脚
\tocloftpagestyle{style@normal}
% 目录和索引标题居中，包含fixhead
\renewcommand{\cfttoctitlefont}{\cqu@fixhead\hfill\heiti\zihao{3}}
\renewcommand{\cftloftitlefont}{\cqu@fixhead\hfill\heiti\zihao{3}}
\renewcommand{\cftlottitlefont}{\cqu@fixhead\hfill\heiti\zihao{3}}
\renewcommand{\cftequtitlefont}{\cqu@fixhead\hfill\heiti\zihao{3}}
\renewcommand{\cftaftertoctitle}{\hfill}
\renewcommand{\cftafterloftitle}{\hfill}
\renewcommand{\cftafterlottitle}{\hfill}
\renewcommand{\cftafterequtitle}{\hfill}
% 重写使用tocloft宏包情况下的目录和索引生成，每次生成新开一页
\ifcqu@continuoustoc\relax\else
	\renewcommand{\@cfttocstart}{\clearpage}
	\renewcommand{\@cfttocfinish}{\clearpage}
\fi
% TODO:这个命令暂时没用上，还待观察
%% 定义自己的章节命令\chapterstar，不编号，有目录有页眉
\newcommand{\chapterstar}[1]{%
	\chapter*{#1}%
	\phantomsection
	\@mkboth{#1}{}
	\addcontentsline{toc}{chapter}{#1}}

%% 参考文献
% 定义\inlinecite{}\onlinecite{}
\bibpunct{[}{]}{,}{s}{}{,}
\renewcommand\NAT@citesuper[3]{\ifNAT@swa%
	\unskip\kern\p@\textsuperscript{\NAT@@open #1\NAT@@close}%
	\if*#3*\else\ (#3)\fi\else #1\fi\endgroup}
\DeclareRobustCommand\inlinecite{\@inlinecite}
\def\@inlinecite#1{\begingroup\let\@cite\NAT@citenum\citep{#1}\endgroup}
\let\onlinecite\inlinecite
% 将参考文献加入目录和pdf书签中
\pretocmd{\bibliography}{%
	\clearpage\phantomsection\addcontentsline{toc}{chapter}{\cqu@bib@name}}{}{}
% 减少参考文献占用的空间
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

%% 设置附录

\AtEndOfClass{\input{cquthesis.cfg}}
