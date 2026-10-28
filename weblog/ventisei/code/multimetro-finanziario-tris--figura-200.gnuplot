# multimetro-finanziario-tris--figura-200.gnuplot --
#
# Per ottenere il file output in  formato PNG eseguire al prompt d'una
# shell:
#
#    gnuplot -c filename.gnuplot >output.png
#
# Visualizza impulsi di Dirac come esempio di rappresentazione degli
# stessi.
#

# Imposta il terminale per generare un'immagine PNG
set terminal pngcairo enhanced font 'arial,14' size 1000,600

# Scrive il file png in stdout.
set output

# Titoli e etichette
set title "Esempi d'impulsi di Dirac"
set xlabel "tempo"
set ylabel "intensità"
set grid linewidth 2 linecolor "black"

#             linea continua    spessore linea   colore
set xzeroaxis linetype 1        linewidth 2      linecolor "black"

set samples 1000

# Intervallo per l'asse x
set xrange [-0.1:10]

# Intervallo per l'asse y
set yrange [-5:6]

# Legenda
set key top left

# Definizione delle funzioni e delle costanti

log1p(x) = log (1.0 + x)
expm1(x) = exp (x) - 1.0
u(t)  = (t < 0.0)? 0.0 : 1.0

$imp << EOD
1   -3
2    3
3.5  5
4.8 -2
6   -4
7    2.3
8    1.7
9    3
EOD

set linetype 1 linewidth 2.0 linecolor "red"
# set linetype 2 linewidth 2.0 linecolor "blue"
# set linetype 3 linewidth 2.0 linecolor "dark-green"

# Lo stile "vectors" disegna delle  frecce e richiede una specifica di
# "using" con  4 valori;  ogni freccia  ha un punto  di partenza  e un
# punto d'arrivo; il punto d'arrivo è quello che ha la punta ("head").
#
# I primi  due, dei quattro  valori necessari a disegnare  la freccia,
# sono le coordinate  del punto di partenza: l'ascissa  X e l'ordinata
# Y.
#
# I secondi due, dei quattro  valori necessari a disegnare la freccia,
# descrivono   le   coordinate   del  punto   d'arrivo:   l'incremento
# dell'ascissa DX rispetto a X, l'incremento dell'ordinata DY rispetto
# a  Y.  Le  coordinate  assolute  del punto  d'arrivo  sono (X+DX)  e
# (Y+DY).
#
# Nel nostro caso i valori sono:
#
# 1 - l'ascissa assoluta del punto di partenza della freccia;
#
# (0) - l'ordinata assoluta del punto di partenza della freccia;
#
# (0) -  l'ascissa relativa  a "1" del  punto d'arrivo  della freccia;
# essendo zero: la freccia è verticale;
#
# ($2) - un'espressione  il cui valore $2 è la  versione abbreviata di
# "column(2)"  e si  riferisce alla  seconda colonna  da cui  estrarre
# valori; è l'ordinata del punto  d'arrivo della freccia a partire dal
# valore assoluto "(0)".
#
plot $imp using 1:(0):(0):($2) with vectors head filled notitle

show output

### end of file
