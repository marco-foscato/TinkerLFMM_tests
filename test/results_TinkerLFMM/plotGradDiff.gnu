#!/bin/gnuplot
reset
set termoption enhanced
set style data linespoints
set grid
set ylabel "kcal/mol/Å"
set key bottom center outside horizontal
set xtics out rotate 90
plot "diffEnergyGradient.dat"  u 1:4:xtic(2) tit "{/Symbol D}GradNorm_{tnk-moe}",\
     "" u 1:5:xtic(2) lc 3 tit "{/Symbol D}RMSGrad_{tnk-moe}"

