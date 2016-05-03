% ----- INDENTIFICATION ------
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{cquthesis}[2016/04/03 0.0.2 Chongqing University Thesis Template]


% ----- INITIAL CODE -----
\hyphenation{Cqu-Thesis}
\def\cquthesis\textsc{CquThesis}
\def\version{0.0.2}


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
% 论文是单面打印还是双面打印（默认：自动，手动模式一般不用）
\DeclareBoolOption{liberalformat}
\newif\if@twosideprint
\newif\if@autoprint
\@autoprinttrue
%TODO: 问题：这一段并没有按计划进行
\define@key{cqu}{printmode}{%
	\if #1 auto \relax
	\else
		\@autoprintfalse
		\if #1 oneside \relax @twosideprintfalse
		\else
			\if #1 twoside \relax @twosideprinttrue
			\else
				\@autoprinttrue
				\ClassWarning{cquthesis}%
					{Unexpected printmode, process with AUTO anyway. \MessageBreak
					printmode=[auto|oneside|twoside]}{}
			\fi
		\fi
	\fi}
% 论文是否保密（默认：关）
\DeclareBoolOption{secret}
% 目录中首级标题是否使用Arial字体（默认：开）
\DeclareBoolOption{arialtitle}
% 传递选项给CTEXBOOK
\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{ctexbook}}
% 打开默认选项
\kvsetkeys{cqu}{%
	arialtitle}
\ProcessKeyvalOptions*
\PassOptionsToPackage{no-math}{fontspec}
% 为CtexBook定义选项
\LoadClass[a4paper,oneside,openany,UTF8,zihao=-4,scheme=plain,linespread=1.39]{ctexbook}

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


% ----- PACKAGE LOADING ------  
\RequirePackage{etoolbox}					%.cls工具
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
\includepdfset{fitpaper=true}
\RequirePackage[shortlabels]{enumitem}		%中文更友好的列表环境
\RequirePackage{environ}					%提供另一种环境定义方式
\RequirePackage[bottom,perpage,hang]{footmisc}
\raggedbottom								%脚注控制，脚注每页重新编号
\RequirePackage{pifont}						%带圈数字，后面还需要处理
%定理宏包，兼容模式
\RequirePackage[amsmath,thmmarks,hyperref]{ntheorem}
%参考文献引用宏包
\RequirePackage[square,comma,super,sort&compress]{natbib}
\RequirePackage{hyperref}
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
	pdfborder= 0 0 0}
\urlstyle{same}
%TODO: 提升：在hyperref之后在正文手动载入breakurl，处理dvips模式下的网址断字问题
% ----- MAIN CODE ------
% 定义清空页面（另开右页）功能和页面的三种形态
% 注意这里另开右页对于单页打印模式来说没有意义，需要做个判断，按条件调整\cleardoublepage的意思。
\let \cqu@cleardoublepage \cleardoublepage
\renewcommand{\cleardoublepage}{\clearpage{\pagestyle{style@empty}}\cqu@cleardoublepage}

\newif\if@mainmatter
\renewcommand{\frontmatter}{%
	\@mainmatterfalse
	\clearpage
	\pagenumbering{Roman}
	\pagestyle{style@empty}
}
\renewcommand{\mainmatter}{%
	\@mainmattertrue
	\cleardoublepage
	\pagenumbering{arabic}
	\pagestyle{style@normal}
}
\renewcommand{\backmatter}{%
	\@mainmattertrue
	\cleardoublepage
}

% 定义页面，页眉页脚，先建立页面环境，完成分页再决定单双面打印
\RequirePackage{geometry}
\geometry{
	a4paper, ignoreall, nomarginpar,
	inner=25mm, outer=25mm, top=30mm, bottom=25mm,
	bindingoffset=10mm, head=16mm, headsep=5mm, foot=15mm, footnotesep=5mm}

% 重大的单双面打印和论文实际页数有关，此处读取最大页码，自动判断是否需要双面打印。
\usepackage{totcount}
\regtotcounter[auxfile=maxpage.aux]{page}
%\usetotcountfile{maxpage.aux}	%测试用
\if@autoprint
	\ifcqu@bachelor
		\ifnum\totvalue{page}>70 \@twosideprinttrue\fi	%很有趣，本科生想要双面打印比硕士生还难
	\else
		\ifnum \totvalue{page}>60 \@twosideprinttrue\fi
	\fi
\fi
% 决定单页/双页打印
\if@twosideprint \geometry{twoside}\fi

% 定义页眉页脚
\RequirePackage{fancyhdr}

% 定制页眉页脚模式，全部以style@开头
% 1. 页眉页脚全空（用于标题页、主体部分另页右开等）
\fancypagestyle{style@empty}{%
	\fancyhf{}
	\renewcommand{\headrulewidth}{0pt}
	\renewcommand{\footrulewidth}{0pt}}
% 2. 仅显示页码（用于目录等页面）
\fancypagestyle{style@justPageNum}{%
	\fancyhead{}
	\fancyfoot[C]{\zihao{-5}\thepage}
	\renewcommand{\headrulewidth}{0pt}
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

%\pagestyle{style@normal} % 开发用
\AtBeginDocument{%
	\pagestyle{style@empty}
	\renewcommand{\chaptermark}[1]{\@mkboth{\CTEXthechapter\hskip\ccwd#1}{}}}

% 定义正文字号，小四号（12bp），行距为固定值20bp
%\abovedisplayskip = 20bp \@plus 2bp \@minus 2bp
%\abovedisplayshortskip = 20bp \@plus 2bp \@minus 2bp
%\belowdisplayskip = \abovedisplayskip
%\belowdisplayshortskip = \abovedisplayshortskip

% 段落
% LaTeX使用\if@afterindent来决定要不要让标题后的第一个自然段缩进，中文环境下好像并没有
% 个人喜好之类的问题，我们这里让它一直为True. 感谢indentfirst.
\let\@afterindentfalse\@afterindenttrue
\@afterindenttrue
% 每个自然段之间空1/10行距，增加可读性
\setlength{\parskip}{0.1\baselineskip}
% 全文首行缩进两字符，开明标点，去掉列表中项目之间的额外间隔（enumitem）
\ctexset{%
	punct=kaiming,
	autoindent=true,
	space=auto}
\setlist{nosep}

% 脚注
% TODO: 尝试使用\tikz来解决脚注数目不足的问题
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

% 设置目录
\renewcommand{\cfttoctitlefont}{\songti\zihao{-2}}
\renewcommand{\cftloftitlefont}{\songti\zihao{-2}}
\renewcommand{\cftlottitlefont}{\songti\zihao{-2}}







\AtEndOfClass{\input{cquthesis.cfg}}