# vim: set ft=perl:
$pdflatex = 'xelatex -quiet -halt-on-error -interaction=nonstopmode %O %S';
$pdf_mode = 1;
$postscript_mode = $dvi_mode = 0;
$clean_ext = '.aux .bbl equ glo gls hd idx ilg ind lof lot out blg log thm toc synctex.gz lofEN lotEN equEN';
$makeindex = 'makeindex -s gind.ist %O -o %D %S';
add_cus_dep('glo', 'gls', 0, 'makeglo2gls');
sub makeglo2gls {
    system("makeindex -s gglo.ist -o \"$_[0].gls\" \"$_[0].glo\"");
}

# ---- 类文件自动解包 -------------------------------------------------
# cquthesis.cls / cquthesis.cfg 由 cquthesis.ins 从 cquthesis.dtx 生成，
# 因为属于生成物不入库。若缺失、或 .dtx/.ins 比它们新，则先解包一次，
# 避免误用 TeX Live 里 CTAN 的旧版 cquthesis。
sub _pack_if_needed {
    my $cls = 'cquthesis.cls';
    my $cfg = 'cquthesis.cfg';
    my $src = (stat('cquthesis.dtx'))[9] // 0;
    my $ins = (stat('cquthesis.ins'))[9] // 0;
    my $need = 0;
    for my $f ($cls, $cfg) {
        next if -e $f && (stat($f))[9] >= $src && (stat($f))[9] >= $ins;
        $need = 1;
    }
    if ($need) {
        print "--- cquthesis.cls 缺失或过期，正在运行 cquthesis.ins ---\n";
        system('xelatex -interaction=nonstopmode cquthesis.ins > /dev/null 2>&1');
    }
}
_pack_if_needed();
