# multimetro-finanziario--figura-50.gnuplot --
#
# Per ottenere il file output in formato PNG eseguire al prompt d'una
# shell:
#
#    gnuplot -c multimetro-finanziario--figura-50.gnuplot
#
# Visualizza il controvalore del multimetro con un versamento e un
# prelievo, con liquidazione totale.
#

# Imposta il terminale per generare un'immagine PNG
set terminal pngcairo enhanced font 'arial,14' size 1000,600

# Nome del file di output
set output

# Titoli e etichette
set title "Controvalore del multimetro con un versamento seguito da liquidazione totale"
set xlabel "tempo"
set ylabel "controvalore"
set grid linewidth 2 linecolor "black"

set samples 1000

# Intervallo per l'asse x
set xrange [-0.5:1.5]

# Intervallo per l'asse y
set yrange [0:120]

# Legenda
set key top left

# Definizione delle funzioni e delle costanti

log1p(x) = log (1 + x)
u(t) = (t < 0)? 0 : 1

L = log1p(0.05)

C0 = +100
C1 = -105

t0 = 0
t1 = 1

V(t) = C0 * u(t - t0) * exp(L * (t - t0)) + \
     + C1 * u(t - t1) * exp(L * (t - t1))

# Plotta le funzioni
plot V(t) with lines linewidth 2

show output

### end of file
