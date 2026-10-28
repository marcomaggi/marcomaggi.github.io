# multimetro-finanziario--figura-55.gnuplot --
#
# Per ottenere il file output in formato PNG eseguire al prompt d'una
# shell:
#
#    gnuplot -c multimetro-finanziario--figura-55.gnuplot
#
# Visualizza il controvalore del multimetro attualizzato.
#

# Imposta il terminale per generare un'immagine PNG
set terminal pngcairo enhanced font 'arial,14' size 1000,600

# Nome del file di output
set output

# Titoli e etichette
set title "Controvalore proprio del multimetro e attualizzato a t = 0 in modo equivalente per t >= 4"
set xlabel "tempo"
set ylabel "controvalore"
set grid linewidth 2 linecolor "black"

set samples 1000

# Intervallo per l'asse x
set xrange [-0.5:5]

# Intervallo per l'asse y
set yrange [0:2.5]

# Legenda
set key top left

# Definizione delle funzioni e delle costanti

log1p(x) = log (1 + x)
u(t) = (t < 0)? 0 : 1

L = log1p(0.05)

C0 = +1
C1 = +0.3
C2 = +0.4
C3 = -0.5
C4 = +0.7

t0 = 0
t1 = 1
t2 = 2
t3 = 3
t4 = 4

# Questo è l'istante di attualizzazione.
a = t0

U(t) = C0 * u(t - t0) * exp(L * (t - t0)) + \
     + C1 * u(t - t1) * exp(L * (t - t1)) + \
     + C2 * u(t - t2) * exp(L * (t - t2)) + \
     + C3 * u(t - t3) * exp(L * (t - t3)) + \
     + C4 * u(t - t4) * exp(L * (t - t4))

V(t) = u(t - a) * exp(L * (t - a)) * ( \
     C0 * exp(L * (a - t0)) + \
     C1 * exp(L * (a - t1)) + \
     C2 * exp(L * (a - t2)) + \
     C3 * exp(L * (a - t3)) + \
     C4 * exp(L * (a - t4)) \
     )

# Plotta le funzioni
plot U(t) with lines linewidth 2 title "Controvalore del multimetro", \
     V(t) with lines linewidth 2 title "Controvalore attualizzato"

show output

### end of file
