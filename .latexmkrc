# vim: set ft=perl:
$clean_ext = '.aux .bbl equ glo gls hd idx ilg ind lof lot out blg log thm toc synctex.gz';
$makeindex = 'makeindex -s gind.ist %O -o %D %S';
add_cus_dep('glo', 'gls', 0, 'makeglo2gls');
sub makeglo2gls {
    system("makeindex -s gglo.ist -o \"$_[0].gls\" \"$_[0].glo\"");
}