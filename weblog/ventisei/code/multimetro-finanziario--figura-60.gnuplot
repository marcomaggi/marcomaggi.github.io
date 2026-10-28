# multimetro-finanziario--figura-60.gnuplot --
#
# Per ottenere il file output in formato PNG eseguire al prompt d'una
# shell:
#
#    gnuplot -c multimetro-finanziario--figura-60.gnuplot
#
# Visualizza una sequenza di cedole che rendono il controvalore uguale
# a quello del multimetro per istanti interi.
#

# Imposta il terminale per generare un'immagine PNG
set terminal pngcairo enhanced font 'arial,14' size 1000,600

# Nome del file di output
set output

# Titoli e etichette
set title "Cedole equivalenti alla risposta del multimetro"
set xlabel "Tempo"
set ylabel "Controvalore"
set grid linewidth 2 linecolor "black"

set samples 1000

# Intervallo per l'asse x
set xrange [-1:6]

# Intervallo per l'asse y
set yrange [90:+140]

# Legenda
set key top left

# Definizione delle funzioni e delle costanti

log1p(x) = log (1 + x)
expm1(x) = exp (x) - 1
u(t) = (t < 0)? 0 : 1

L = log1p(0.05)
C = 100

t0 = 0
t1 = 1
t2 = 2
t3 = 3
t4 = 4
t5 = 5

U(t) = C * u(t - t0) * exp(L * (t - t0))
V(t) = U(0) * u(t - t0) + \
       C * expm1(L) * exp(L * t0) * u(t - t1) + \
       C * expm1(L) * exp(L * t1) * u(t - t2) + \
       C * expm1(L) * exp(L * t2) * u(t - t3) + \
       C * expm1(L) * exp(L * t3) * u(t - t4) + \
       C * expm1(L) * exp(L * t4) * u(t - t5)

# Plotta le funzioni
plot U(t) with lines linewidth 2 title "controvalore esponenziale U(t)", \
     V(t) with lines linewidth 2 title "controvalore con gradinata di cedole equivalenti V(t)"

show output

### end of file
