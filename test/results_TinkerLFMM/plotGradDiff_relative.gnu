#!/bin/gnuplot
reset
set termoption enhanced
set multiplot
set style data histogram
set style histogram gap 1
set style fill solid border 3
set boxwidth 1
set tmargin at screen 0.98
set bmargin at screen 0.65
set lmargin at screen 0.1
set rmargin at screen 0.98
set yrange [0.0015:0.025]
set xrange [-1:83]
set xtics -1,1,78 scale 0 
set xtics format " "
set border 14
set grid front
unset key
plot "diffEnergyGradient_relative.dat"  u (abs($5/$4*100))

set border 11
set tmargin at screen 0.60
set bmargin at screen 0.15
set yrange [0:0.0013]
set xtics 0,0.001
set xtics scale 0 nomirror
set ylabel "|{/Symbol D}GNorm_{tnk-moe} / Gnorm_{moe}| %" offset 0,5
set xlabel "Test ID"
set xtics out rotate 90
set grid front
plot "diffEnergyGradient_relative.dat"  u (abs($5/$4*100)):xtic(2) 
unset multiplot
