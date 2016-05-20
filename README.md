# 嗨，这里是CQUThesis！
CQUThesis表示的是**C**hong**Q**ing **U**niversity **Thesis**.

本宏包是重庆大学毕业论文的`\LaTeX{}`模板，支持学士、硕士、博士论文的排版。合理使用本宏包可以大大减轻重庆大学毕业生在毕业论文撰写过程中的排版工作量。
	
CQUThesis根据重庆大学《重庆大学本科设计（论文）撰写规范化要求（2007年修订版）》和《重庆大学博士、硕士论文撰写格式标准（2007年修订版）》编写，力求合规，简洁，易于实现，用户友好。

# 模板特色
* 支持重庆大学本科（文学、理工）、硕士（学术、专业）、博士的毕业论文格式；
* 内置封面、目录、索引、授权书等论文部件，可按需自动生成；
* 自动侦测文档页数，生成相应的单面打印/双面打印PDF文件；
* 预置一批按毕业论文环境优化过的宏包和小功能，包含国际标准单位、化学式支持、三线表等，可按需开启。

![CQUThesis-Poster](https://cloud.githubusercontent.com/assets/8143068/15363773/68c6b380-1d4c-11e6-9627-4d892facb333.png)

# 获取CQUThesis
## 下载
版本	|	下载地址	|	描述
---	|	---
发行版	|	*正在上线*	|	敬请期待
开发版	|[点我下载](https://github.com/nanmu42/cquthesis/zipball/master)	|	最新的功能，最快的BugFix
用户文档|[点我下载](https://github.com/nanmu42/CQUThesis/files/273864/cquthesis.pdf)	|	阐述模板使用方法和代码实现，推荐参考

## 部署
请编译`main.tex`获得示例文档，其中`图1.1`为CQUThesis文件结构，请创建一个新的文件夹作为根目录。

必要文件列举如下：
* 模板文件：`cquthesis.cls`, `cquthesis.cfg`, `cquthesis.sty`以及`cqunumberical.bst`，位于根目录；
* 内容文件夹：`contents`, `figures`, `ref`（推荐），都位于根目录；
* `contents`内的必要文件：`ack.tex`, `appendix.tex`, `cover.tex`, `denotation.tex`，将这些文件按文件结构安排至根目录中；
* 最后请将`main.tex`置于根目录，工作即可开始。

## 更新
需要更新时，请从GIthub下载zip文档后解压，使用命令行定位到文件夹，运行：
`latex cquthesis.ins`
即可完成更新。

# 文档
* 示例文档	请编译`main.tex`获得
* 用户文档	[点我下载](https://github.com/nanmu42/CQUThesis/files/273864/cquthesis.pdf)

# 提问和支持
* [Github Issues](https://github.com/nanmu42/CQUThesis/issues)
* 造访重庆大学7117工作室寻求支持

# 用户协议
1. 本模板按照LaTeX Project Public License发布，协议版本号为1.2或以后的任何版本（随你意）；
1. 重庆大学教务处和研究生院只提供毕业论文写作指南，不提供官方模板，也不会授权或认证第三方模板为官方模板。
这个模板是按照写作指南的参考实现，模板作者自当尽力，但不保证审查老师不提意见。任何由于本模板而引起的论文格式审查问题与本模板作者无关。

# About CQUThesis
CQUThesis stands for Chongqing University Thesis Template for LaTeX, bearing the ability to support bachelor,
master, doctor dissertations.

# 致谢 / Acknowledgements
这个模板是站在巨人肩膀上的成果，感谢LaTeX 2e计划，感谢[CTeX社区](https://github.com/CTeX-org/ctex-kit)提供的中文解决方案，感谢薛瑞尼副教授的[先驱之作](https://github.com/xueruini/thuthesis)，感谢[中国科学技术大学TeX用户组](https://github.com/ustctug/gbt-7714-20155)。向你们致以真诚的问候和感激！

世界因你们更美好。

The author would like to acknowledge these contributors for their efforts and, essentially, beautiful mind:

* [The CTeX Community](https://github.com/CTeX-org/ctex-kit)
* [XUE, Ruini](https://github.com/xueruini/thuthesis)
* [USTC TeX User Group](https://github.com/ustctug/gbt-7714-20155)
