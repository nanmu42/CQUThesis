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
\newif\if@usermadechoice
\newif\ifcqu@bachelor
\newif\ifcqu@master
\newif\ifcqu@doctor
\define@key{cqu}{type}{%
	\expandafter\csname cqu@#1true\endcsname
	\@usermadechoicetrue}
% 论文是单面打印还是双面打印（默认：自动，手动模式一般不用）
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
\LoadClass[a4paper,oneside,openany,UTF8,zihao=-4,scheme=plain]{ctexbook}

% 用户必须提供用户类型
\if@usermadechoice\relax\else
	\ClassError{cquthesis}%
		{Specified thesis type is obligatory: \MessageBreak
			type=[bachelor|master|doctor]}{}
\fi


% ----- PACKAGE LOADING ------  
\RequirePackage{etoolbox}					%.cls工具
\RequirePackage{ifxetex}
\RequirePackage{amsmath}					%更好的数学公式支持
\RequirePackage{xparse}						%更好的命令定义
\RequirePackage[defaultsups]{newtxtext}		%英文字体支持
\RequirePackage{newtxmath}					%数学字体支持
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
\RequirePackage[numbers,super,sort&compress]{natbib}
\RequirePackage{hyperref}
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

% TODO: 轮廓：页眉页脚需要根据文档类型和单双页相应变动
% 定制页眉页脚模式，全部以style@开头
% 1. 页眉页脚全空（用于标题页、主体部分另页右开等）
\fancypagestyle{style@empty}{%
	\fancyhf{}
	\renewcommand{\headrulewidth}{0pt}
	\renewcommand{\footrulewidth}{0pt}}
% 2. 仅显示页码（用于章节开头）
\fancypagestyle{style@justPageNum}{%
	\fancyhead{}
	\fancyfoot[C]{\zihao{5}\thepage}
	\renewcommand{\headrulewidth}{0pt}
	\renewcommand{\footrulewidth}{0pt}}
% 3. 页眉页脚齐全（用于一般正文页面）
\fancypagestyle{style@normal}{%
	\fancyhead{}
	\fancyhead[C]{\zihao{-5}\songti\rightmark}
	\fancyfoot{}
	\fancyfoot[C]{\zihao{-5}\thepage}
	\renewcommand{\headrulewidth}{0.4pt}
	\renewcommand{\footrulewidth}{0pt}}

\pagestyle{style@normal} % 开发用

% 定义正文字号，小四号（12bp），行距为固定值20bp
\abovedisplayskip = 20bp \@plus 2bp \@minus 2bp
\abovedisplayshortskip = 20bp \@plus 2bp \@minus 2bp
\belowdisplayskip = \abovedisplayskip
\belowdisplayshortskip = \abovedisplayshortskip

% 段落
% 全文首行缩进两字符，开明标点，去掉列表中项目之间的额外间隔（enumitem）
\ctexset{%
	punct=kaiming,
	autoindent=true,
	space=auto}
\setlist{nosep}

% 脚注
% 用带圈的数字作为脚注，由于字体限制，最多能在单页上处理10个脚注
%\def\circlenum#1{%
%	(#1)
%%	\ifnum\value{#1} >10
%%		\ClassError{cquthesis}%
%%			{In a single page, Footnotes more than 10 are not supported.}
%%	\fi
%	\ding{\numexpr171+\value{#1}}%
%	\ding{\numexpr171+\value{#1}}%
%}
\def\circleNum#1{%
	\ifnum\value{#1} >9
	\ClassError{thuthesis}%
	{Too many footnotes in this page.}{Keep footnote less than 10.}
	\fi
	\ifthu@pifootnote%
	\ding{\numexpr171+\value{#1}}%
	\else%
	\textcircled{\xiaoliu\arabic{#1}}%
	\fi}


\AtEndOfClass{\input{cquthesis.cfg}}