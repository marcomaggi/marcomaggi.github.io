# multimetro-finanziario--figura-20.gnuplot --
#
# Per ottenere il file output in formato PNG eseguire al prompt d'una
# shell:
#
#    gnuplot -c multimetro-finanziario--figura-20.gnuplot
#
# Visualizza funzioni esponenziali per diversi valori dell'ampiezza.
#

# Imposta il terminale per generare un'immagine PNG
set terminal pngcairo enhanced font 'arial,14' size 1000,600

# Nome del file di output
set output

# Titoli e etichette
set title "Esponenziali con diversi valori d'ampiezza"
set xlabel "tempo"
set ylabel "valore"
set grid linewidth 2 linecolor "black"

set samples 1000

# Intervallo per l'asse x
set xrange [-20:120]

# Intervallo per l'asse y
set yrange [0:10]

# Legenda
set key top left

# Definizione delle funzioni e delle costanti

log1p(x) = log (1 + x)
u(t) = (t < 0)? 0 : 1

L = log1p(0.04)

C1 = 0.1
C2 = 0.2
C3 = 0.3
C4 = 0.4
C5 = 0.5

f1(t) = C1 * exp(L * t)
f2(t) = C2 * exp(L * t)
f3(t) = C3 * exp(L * t)
f4(t) = C4 * exp(L * t)
f5(t) = C5 * exp(L * t)

# Plotta le funzioni
plot f1(t) with lines linewidth 2 title "C = 0,1; {/Symbol l} = 0,04", \
     f2(t) with lines linewidth 2 title "C = 0,2; {/Symbol l} = 0,04", \
     f3(t) with lines linewidth 2 title "C = 0,3; {/Symbol l} = 0,04", \
     f4(t) with lines linewidth 2 title "C = 0,4; {/Symbol l} = 0,04", \
     f5(t) with lines linewidth 2 title "C = 0,5; {/Symbol l} = 0,04"

show output

### end of file
