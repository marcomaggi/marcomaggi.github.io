# multimetro-finanziario--figura-70.gnuplot --
#
# Per ottenere il file output in formato PNG eseguire al prompt d'una
# shell:
#
#    gnuplot -c multimetro-finanziario--figura-70.gnuplot
#
# Visualizza l'inserzione del multimetro per misurare il rendimento
# effettivo d'un titolo finanziario in un determinato periodo di
# tempo.
#

# Imposta il terminale per generare un'immagine PNG
set terminal pngcairo enhanced font 'arial,14' size 1000,600

# Nome del file di output
set output

# Titoli e etichette
set title "Misura del rendimento effettivo d'un titolo finanziario tramite inserzione del multimetro"
set xlabel "Tempo"
set ylabel "Controvalore"
set grid linewidth 2 linecolor "black"

set samples 300

# Intervallo per l'asse x
set xrange [-1:21]

# Intervallo per l'asse y
set yrange [0:+350]

# Legenda
set key top left

# Definizione delle funzioni e delle costanti

log1p(x) = log (1 + x)
expm1(x) = exp (x) - 1
u(t) = (t < 0)? 0 : 1

t0 = 0
t1 = 20

V0 = 123.45
V1 = 234.56

Vnoise(t) = 100 * rand(0) * sin( (2 * pi / (2 * (t1 - t0))) * t)
V(t) = ((V1 - V0) / (t1 - t0)) * t + V0 + Vnoise(t)

L = (log(V1) - log(V0)) / (t1 - t0)

# Reset the seed of the pseudo-random numbers generator.
#rand(-1)

U(t) = V(t0) * u(t - t0) * exp(L * (t - t0)) - V(t1) * u(t - t1) * exp(L * (t - t1))

# Plotta le funzioni
plot V(t) with lines linewidth 2 title "controvalore d'un titolo finanziario V(t)", \
     U(t) with lines linewidth 2 title \
     "controvalore del multimetro inserito come rendimentometro U(t)"

show output

### end of file
