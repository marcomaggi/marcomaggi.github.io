# multimetro-finanziario-bis--figura-10.gnuplot --
#
# Per ottenere il file output in formato PNG eseguire al prompt d'una
# shell:
#
#    gnuplot -c filename.gnuplot
#
# Visualizza il cash drag.
#

# Imposta il terminale per generare un'immagine PNG
set terminal pngcairo enhanced font 'arial,14' size 1000,600

# Nome del file di output
set output

# Titoli e etichette
set title "Effetto del {/:Italic cash drag} sul rendimento effettivo d'un portafoglio finanziario"
set xlabel "tempo"
set ylabel "valore"
set grid linewidth 2 linecolor "black"

set samples 1000

# Intervallo per l'asse x
set xrange [-0.5:20.0]

# Intervallo per l'asse y
set yrange [-0.5:350.0]

# Legenda
set key top left

# Definizione delle funzioni e delle costanti

log1p(x) = log (1.0 + x)
expm1(x) = exp (x) - 1.0
u(t) = (t < 0.0)? 0.0 : 1.0

Linvesto = log1p(0.05)
Lliquido = log1p(0.0)

t0 =   0.0
C0 = 100.0
C1 =  23.0

U(t) = \
  C0 * u(t - t0) * exp(Linvesto * (t - t0)) + \
  C1 * u(t - t0) * exp(Lliquido * (t - t0))

V(t) = \
  C0 * u(t - t0) * exp(Linvesto * (t - t0)) + \
  C1 * u(t - t0) * exp(Linvesto * (t - t0))

set linetype 1 linewidth 2.0 linecolor "red"
set linetype 2 linewidth 2.0 linecolor "blue"

# Plotta le funzioni
plot \
  U(t) title "Controvalore con {/:Italic cash drag}", \
  V(t) title "Controvalore tutto investito"

show output

### end of file
