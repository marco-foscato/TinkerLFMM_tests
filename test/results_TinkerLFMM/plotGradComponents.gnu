#!/bin/gnuplot
reset
set termoption enhanced
set style data points
set grid
set key bottom center outside horizontal
set xtics out rotate 90
set ylabel 'max {/Symbol D}Grad_{x_{i};tnk-moe}'
set xlabel 'Test ID'
plot "diffGradComponents.dat" u 1:67:xtic(2) title "LFSE" ,\
     "" u 1:52:xtic(2) title "mors",\
     "" u 1:57:xtic(2) title "llr",\
     "" u 1:62:xtic(2) title "pair",\
     "" u 1:7:xtic(2) pt 6 lc 7 title "str",\
     "" u 1:12:xtic(2) pt 8 lc rgbcolor 'forest-green' title "ang",\
     "" u 1:17:xtic(2) pt 10 lc 3 title "stb",\
     "" u 1:22:xtic(2) pt 12 title "oop",\
     "" u 1:27:xtic(2) pt 2 title "tor",\
     "" u 1:32:xtic(2) pt 4 title "vdw",\
     "" u 1:37:xtic(2) pt 6 lc 4 title "chg"

#plot "diffGradComponents.dat" u 1:7:xtic(2) title column,\
#     "" u 1:12:xtic(2) title column,\
#     "" u 1:17:xtic(2) title column,\
#     "" u 1:22:xtic(2) title column,\
#     "" u 1:27:xtic(2) title column,\
#     "" u 1:32:xtic(2) lc 0 title column,\
#     "" u 1:37:xtic(2) title column,\
#     "" u 1:42:xtic(2) title column,\
#     "" u 1:47:xtic(2) title column,\
#     "" u 1:52:xtic(2) title column,\
#     "" u 1:57:xtic(2) title column,\
#     "" u 1:62:xtic(2) title column,\
#     "" u 1:67:xtic(2) title column


