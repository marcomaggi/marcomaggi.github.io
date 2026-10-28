# recensione-autocensurata-septies--grafici-tco.gnuplot --
#
# Il template iniziale è stato generato con Mistral.  Per ottenere il
# file output in formato PNG eseguire al prompt d'una shell:
#
#    gnuplot -c recensione-autocensurata-septies--grafici-tco.gnuplot
#

# Imposta il terminale per generare un'immagine PNG
set terminal pngcairo enhanced font 'arial,10' size 800,600

# Nome del file di output
set output

# Titoli e etichette
set title "Grafici delle funzioni TCO"
set xlabel "t"
set ylabel "TCO"
set grid linewidth 2 linecolor "black"

set samples 1000

# Intervallo per l'asse x
set xrange [0:11]

# Intervallo per l'asse y
set yrange [0:4]

# Legenda
set key top left

log1p(x) = log (1 + x)
L = log1p(0.03)
u(t) = (t < 0)? 0 : 1

F  = 1
G  = 2.2
Cf = 0.1
Cg = 0.05

# Definizione delle funzioni
f(t) = F * exp(L * t) + \
  Cf * exp(L * (t - 0)) * u(t - 0) + \
  Cf * exp(L * (t - 1)) * u(t - 1) + \
  Cf * exp(L * (t - 2)) * u(t - 2) + \
  Cf * exp(L * (t - 3)) * u(t - 3) + \
  Cf * exp(L * (t - 4)) * u(t - 4) + \
  Cf * exp(L * (t - 5)) * u(t - 5) + \
  Cf * exp(L * (t - 6)) * u(t - 6) + \
  Cf * exp(L * (t - 7)) * u(t - 7) + \
  Cf * exp(L * (t - 8)) * u(t - 8) + \
  Cf * exp(L * (t - 9)) * u(t - 9) + \
  Cf * exp(L * (t - 10)) * u(t - 10)

g(t) = G * exp(L * t) + \
  Cg * exp(L * (t - 0)) * u(t - 0) + \
  Cg * exp(L * (t - 1)) * u(t - 1) + \
  Cg * exp(L * (t - 2)) * u(t - 2) + \
  Cg * exp(L * (t - 3)) * u(t - 3) + \
  Cg * exp(L * (t - 4)) * u(t - 4) + \
  Cg * exp(L * (t - 5)) * u(t - 5) + \
  Cg * exp(L * (t - 6)) * u(t - 6) + \
  Cg * exp(L * (t - 7)) * u(t - 7) + \
  Cg * exp(L * (t - 8)) * u(t - 8) + \
  Cg * exp(L * (t - 9)) * u(t - 9) + \
  Cg * exp(L * (t - 10)) * u(t - 10)

# Plotta le funzioni
plot f(t) with lines linewidth 2 linecolor "green" title "TCO mio", \
     g(t) with lines linewidth 2 linecolor "red"   title "TCO del dottore"

show output

### end of file
