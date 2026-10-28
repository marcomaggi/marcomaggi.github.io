# multimetro-finanziario--figura-80.gnuplot --
#
# Per ottenere il file output in formato PNG eseguire al prompt d'una
# shell:
#
#    gnuplot -c multimetro-finanziario--figura-80.gnuplot
#
# Visualizza il valore reale, svalutato dall'inflazione, in termini di
# controvalore d'un multimetro.
#

# Imposta il terminale per generare un'immagine PNG
set terminal pngcairo enhanced font 'arial,14' size 1000,600

# Nome del file di output
set output

# Titoli e etichette
set title "Drenaggio causa inflazione del potere d'acquisto d'un capitale non investito"
set xlabel "tempo"
set ylabel "controvalore"
set grid linewidth 2 linecolor "black"

set samples 1000

# Intervallo per l'asse x
set xrange [-0.5:20]

# Intervallo per l'asse y
set yrange [0:17]

# Legenda
set key top left

# Definizione delle funzioni e delle costanti

log1p(x) = log (1 + x)
u(t) = (t < 0)? 0 : 1

Ldeposito   = log1p(0.0)
Linflazione = log1p(0.02)
Lpotere     = Ldeposito - Linflazione

C0 = +10
t0 = 0
U(t) = C0 * u(t - t0) * exp(Ldeposito * (t - t0))
P(t) = C0 * u(t - t0) * exp(Linflazione * (t - t0))
Q(t) = C0 * u(t - t0) * exp(Lpotere * (t - t0))

# Plotta le funzioni
plot \
  U(t) with lines linewidth 2 title "Controvalore d'un deposito inerte, U(t)", \
  P(t) with lines linewidth 2 title "Indice dei prezzi, tasso d'inflazione 2%, P(t)", \
  Q(t) with lines linewidth 2 title "Potere d'acquisto del controvalore, Q(t)"

show output

### end of file
