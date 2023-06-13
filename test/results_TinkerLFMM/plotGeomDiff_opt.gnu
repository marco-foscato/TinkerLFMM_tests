#!/bin/gnuplot
reset
set grid
set termoption enhanced
set style data histogram
set style histogram gap 1
set style fill solid border 3
set boxwidth 1
unset key
set xtics out rotate 90 nomirror offset -0.75,0
set ylabel 'RMSD'
set xlabel 'Test ID'
plot "diffGeometries_opt.dat" u 3:xtic(2) lc 3

