# multimetro-finanziario--figura-10.gnuplot --
#
# Per ottenere il file output in formato PNG eseguire al prompt d'una
# shell:
#
#    gnuplot -c multimetro-finanziario--figura-10.gnuplot
#
# Visualizza funzioni esponenziali per diversi valori di lambda.
#

# Imposta il terminale per generare un'immagine PNG
set terminal pngcairo enhanced font 'arial,14' size 1000,600

# Nome del file di output
set output

# Titoli e etichette
set title "Esponenziali con diversi valori di lambda"
set xlabel "tempo"
set ylabel "valore"
set grid linewidth 2 linecolor "black"

set samples 1000

# Intervallo per l'asse x
set xrange [-0.5:1.1]

# Intervallo per l'asse y
set yrange [0.97:1.07]

# Legenda
set key top left

# Definizione delle funzioni e delle costanti

log1p(x) = log (1 + x)
u(t) = (t < 0)? 0 : 1

L1 = 0.01
L2 = 0.02
L3 = 0.03
L4 = 0.04
L5 = 0.05

f1(t) = exp(L1 * t)
f2(t) = exp(L2 * t)
f3(t) = exp(L3 * t)
f4(t) = exp(L4 * t)
f5(t) = exp(L5 * t)

# Plotta le funzioni
plot f1(t) with lines linewidth 2 title "C = 1, {/Symbol l} = 0,01", \
     f2(t) with lines linewidth 2 title "C = 1, {/Symbol l} = 0,02", \
     f3(t) with lines linewidth 2 title "C = 1, {/Symbol l} = 0,03", \
     f4(t) with lines linewidth 2 title "C = 1, {/Symbol l} = 0,04", \
     f5(t) with lines linewidth 2 title "C = 1, {/Symbol l} = 0,05"

show output

### end of file
