#!/bin/gnuplot
reset

set termoption enhanced
set grid front
set key bottom center outside horizontal
set xtics out rotate 90 scale 0 
set xlabel 'Test ID'
set ylabel '|{/Symbol D}E_{i; tnk-moe} / E_{tot; moe}| [%]'
set grid front
plot 'diffEnergyTerms_relative.dat' u 1:(abs($6/$61*100)):xtic(2)  tit "LFSE" ,\
                                 '' u 1:(abs($10/$61*100)):xtic(2)  tit "mors" ,\
                                 '' u 1:(abs($18/$61*100)):xtic(2)  tit "llr" ,\
                                 '' u 1:(abs($26/$61*100)):xtic(2)  tit "pair" ,\
                                 '' u 1:(abs($30/$61*100)):xtic(2) pt 6 lc 7 tit "str" ,\
                                 '' u 1:(abs($34/$61*100)):xtic(2) pt 8 lc rgbcolor 'forest-green' tit "ang" ,\
                                 '' u 1:(abs($38/$61*100)):xtic(2) pt 10 lc 3 tit "stb" ,\
                                 '' u 1:(abs($42/$61*100)):xtic(2) pt 12 tit "oop" ,\
                                 '' u 1:(abs($46/$61*100)):xtic(2) pt 2 tit "tor" ,\
                                 '' u 1:(abs($50/$61*100)):xtic(2) pt 4 tit "vdw" ,\
                                 '' u 1:(abs($54/$61*100)):xtic(2) pt 6 lc 4 tit "ele" 

