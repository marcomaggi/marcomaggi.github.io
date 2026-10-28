# multimetro-finanziario--figura-30.gnuplot --
#
# Per ottenere il file output in formato PNG eseguire al prompt d'una
# shell:
#
#    gnuplot -c multimetro-finanziario--figura-30.gnuplot
#
# Visualizza funzioni  esponenziali a  gradino per diversi  valori del
# ritardo.
#

# Imposta il terminale per generare un'immagine PNG
set terminal pngcairo enhanced font 'arial,14' size 1000,600

# Nome del file di output
set output

# Titoli e etichette
set title "Esponenziali a gradino con diversi valori di ritardo"
set xlabel "tempo"
set ylabel "valore"
set grid linewidth 2 linecolor "black"

set samples 1000

# Intervallo per l'asse x
set xrange [-10:30]

# Intervallo per l'asse y
set yrange [0:4]

# Legenda
set key top left

# Definizione delle funzioni e delle costanti

log1p(x) = log (1 + x)
u(t) = (t < 0)? 0 : 1

L = log1p(0.04)

t1 = -5
t2 = -2
t3 = +0
t4 = +3
t5 = +6

f1(t) = exp(L * (t - t1)) * u(t - t1)
f2(t) = exp(L * (t - t2)) * u(t - t2)
f3(t) = exp(L * (t - t3)) * u(t - t3)
f4(t) = exp(L * (t - t4)) * u(t - t4)
f5(t) = exp(L * (t - t5)) * u(t - t5)

# Plotta le funzioni
plot f1(t) with lines linewidth 2 title "C = 1; {/Symbol l} = 0,04; t_0 = -5", \
     f2(t) with lines linewidth 2 title "C = 1; {/Symbol l} = 0,04; t_0 = -2", \
     f3(t) with lines linewidth 2 title "C = 1; {/Symbol l} = 0,04; t_0 =  0", \
     f4(t) with lines linewidth 2 title "C = 1; {/Symbol l} = 0,04; t_0 = +3", \
     f5(t) with lines linewidth 2 title "C = 1; {/Symbol l} = 0,04; t_0 = +6"

show output

### end of file
