#!/bin/gnuplot
reset

set termoption enhanced
set style data histogram 
set style histogram gap 1
set style fill solid border 2
set boxwidth 1
set grid front
unset key
set xtics out rotate 90 scale 0 
set xlabel 'Test ID'
set ylabel '|{/Symbol D}E_{tnk-moe} / E_{moe}| [%]'
set grid front
plot 'diffEnergy_opt_relative.dat' u (abs($62/$61*100)):xtic(2) lc 2
