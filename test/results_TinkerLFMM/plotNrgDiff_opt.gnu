#!/bin/gnuplot
reset

set termoption enhanced
set grid
set style data linespoints
set key autotitle columnhead
set key bottom center outside horizontal
set xtics out rotate 90
set ylabel '{/Symbol D}E_{tnk-moe} [kcal/mol]'
set xlabel 'Test ID'
plot 'diffEnergy_opt.dat' u 1:4:xtic(2) ,\
     '' u 1:6:xtic(2) ,\
     '' u 1:10:xtic(2) ,\
     '' u 1:14:xtic(2) ,\
     '' u 1:16:xtic(2) pt 6 lc 7,\
     '' u 1:18:xtic(2) pt 8 lc rgbcolor 'forest-green',\
     '' u 1:20:xtic(2) pt 10 lc 3,\
     '' u 1:22:xtic(2) pt 12,\
     '' u 1:24:xtic(2) pt 2,\
     '' u 1:26:xtic(2) pt 4,\
     '' u 1:28:xtic(2) pt 6 lc 4 ,\
     '' u 1:32:xtic(2) w line lc 0 lw 1.5

