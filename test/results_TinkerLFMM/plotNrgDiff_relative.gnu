#!/bin/gnuplot
reset

set termoption enhanced
set style data histogram 
set style histogram gap 1
set style fill solid border 3
set boxwidth 1
set grid front
unset key
set xtics out rotate 90 scale 0 
set xlabel 'Test ID'
set ylabel '|{/Symbol D}E_{tot; tnk-moe} / E_{tot; moe}| [%]'
#set yrange [-0.0014:0.0002]
#set object 1 rect from -1.5,-0.001 to 78.5,0.001 fc lt -1 fs solid 0.15 noborder back
set grid front
plot 'diffEnergyTerms_relative.dat' u (abs($62/$61*100)):xtic(2) lc 3

