# recensione-autocensurata-septies--grafici-tco-sorpasso.gnuplot --
#
# Il template iniziale è stato generato con Mistral.  Per ottenere il
# file output in formato PNG eseguire al prompt d'una shell:
#
#    gnuplot -c recensione-autocensurata-septies--grafici-tco-sorpasso.gnuplot
#

# Imposta il terminale per generare un'immagine PNG
set terminal pngcairo enhanced font 'arial,10' size 800,600

# Nome del file di output
set output

# Titoli e etichette
set title "Grafici delle funzioni TCO, sorpasso"
set xlabel "t"
set ylabel "TCO"
set grid linewidth 2 linecolor "black"

set samples 1000

# Intervallo per l'asse x
set xrange [0:50]

# Intervallo per l'asse y
set yrange [0:13]

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
  Cf * exp(L * (t - 10)) * u(t - 10) + \
  Cf * exp(L * (t - 11)) * u(t - 11) + \
  Cf * exp(L * (t - 12)) * u(t - 12) + \
  Cf * exp(L * (t - 13)) * u(t - 13) + \
  Cf * exp(L * (t - 14)) * u(t - 14) + \
  Cf * exp(L * (t - 15)) * u(t - 15) + \
  Cf * exp(L * (t - 16)) * u(t - 16) + \
  Cf * exp(L * (t - 17)) * u(t - 17) + \
  Cf * exp(L * (t - 18)) * u(t - 18) + \
  Cf * exp(L * (t - 19)) * u(t - 19) + \
  Cf * exp(L * (t - 20)) * u(t - 20) + \
  Cf * exp(L * (t - 21)) * u(t - 21) + \
  Cf * exp(L * (t - 22)) * u(t - 22) + \
  Cf * exp(L * (t - 23)) * u(t - 23) + \
  Cf * exp(L * (t - 24)) * u(t - 24) + \
  Cf * exp(L * (t - 25)) * u(t - 25) + \
  Cf * exp(L * (t - 26)) * u(t - 26) + \
  Cf * exp(L * (t - 27)) * u(t - 27) + \
  Cf * exp(L * (t - 28)) * u(t - 28) + \
  Cf * exp(L * (t - 29)) * u(t - 29) + \
  Cf * exp(L * (t - 30)) * u(t - 30) + \
  Cf * exp(L * (t - 31)) * u(t - 31) + \
  Cf * exp(L * (t - 32)) * u(t - 32) + \
  Cf * exp(L * (t - 33)) * u(t - 33) + \
  Cf * exp(L * (t - 34)) * u(t - 34) + \
  Cf * exp(L * (t - 35)) * u(t - 35) + \
  Cf * exp(L * (t - 36)) * u(t - 36) + \
  Cf * exp(L * (t - 37)) * u(t - 37) + \
  Cf * exp(L * (t - 38)) * u(t - 38) + \
  Cf * exp(L * (t - 39)) * u(t - 39) + \
  Cf * exp(L * (t - 40)) * u(t - 40) + \
  Cf * exp(L * (t - 41)) * u(t - 41) + \
  Cf * exp(L * (t - 42)) * u(t - 42) + \
  Cf * exp(L * (t - 43)) * u(t - 43) + \
  Cf * exp(L * (t - 44)) * u(t - 44) + \
  Cf * exp(L * (t - 45)) * u(t - 45)

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
  Cg * exp(L * (t - 10)) * u(t - 10) + \
  Cg * exp(L * (t - 11)) * u(t - 11) + \
  Cg * exp(L * (t - 12)) * u(t - 12) + \
  Cg * exp(L * (t - 13)) * u(t - 13) + \
  Cg * exp(L * (t - 14)) * u(t - 14) + \
  Cg * exp(L * (t - 15)) * u(t - 15) + \
  Cg * exp(L * (t - 16)) * u(t - 16) + \
  Cg * exp(L * (t - 17)) * u(t - 17) + \
  Cg * exp(L * (t - 18)) * u(t - 18) + \
  Cg * exp(L * (t - 19)) * u(t - 19) + \
  Cg * exp(L * (t - 20)) * u(t - 20) + \
  Cg * exp(L * (t - 21)) * u(t - 21) + \
  Cg * exp(L * (t - 22)) * u(t - 22) + \
  Cg * exp(L * (t - 23)) * u(t - 23) + \
  Cg * exp(L * (t - 24)) * u(t - 24) + \
  Cg * exp(L * (t - 25)) * u(t - 25) + \
  Cg * exp(L * (t - 26)) * u(t - 26) + \
  Cg * exp(L * (t - 27)) * u(t - 27) + \
  Cg * exp(L * (t - 28)) * u(t - 28) + \
  Cg * exp(L * (t - 29)) * u(t - 29) + \
  Cg * exp(L * (t - 30)) * u(t - 30) + \
  Cg * exp(L * (t - 31)) * u(t - 31) + \
  Cg * exp(L * (t - 32)) * u(t - 32) + \
  Cg * exp(L * (t - 33)) * u(t - 33) + \
  Cg * exp(L * (t - 34)) * u(t - 34) + \
  Cg * exp(L * (t - 35)) * u(t - 35) + \
  Cg * exp(L * (t - 36)) * u(t - 36) + \
  Cg * exp(L * (t - 37)) * u(t - 37) + \
  Cg * exp(L * (t - 38)) * u(t - 38) + \
  Cg * exp(L * (t - 39)) * u(t - 39) + \
  Cg * exp(L * (t - 40)) * u(t - 40) + \
  Cg * exp(L * (t - 41)) * u(t - 41) + \
  Cg * exp(L * (t - 42)) * u(t - 42) + \
  Cg * exp(L * (t - 43)) * u(t - 43) + \
  Cg * exp(L * (t - 44)) * u(t - 44) + \
  Cg * exp(L * (t - 45)) * u(t - 45)

# Plotta le funzioni
plot f(t) with lines linewidth 2 linecolor "green" title "TCO mio", \
     g(t) with lines linewidth 2 linecolor "red"   title "TCO del dottore"

show output

### end of file
