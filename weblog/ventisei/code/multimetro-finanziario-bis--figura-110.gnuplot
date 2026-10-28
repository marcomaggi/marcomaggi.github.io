# multimetro-finanziario-bis--figura-110.gnuplot --
#
# Per ottenere il file output in  formato PNG eseguire al prompt d'una
# shell:
#
#    gnuplot -c multimetro-finanziario-bis--figura-110.gnuplot
#
# Visualizza il calcolo dello Yield to Maturity in funzione del
# prezzo, evidenziando la proporzionalità inversa.
#

# Imposta il terminale per generare un'immagine PNG
set terminal pngcairo enhanced font 'arial,14' size 1000,600

# Nome del file di output
set output

# Titoli e etichette
set title "Proporzionalità tra {/:Italic Yield to Maturity} e prezzo d'una obbligazione"
set xlabel "{/:Italic Yield to Maturity} percentuale"
set ylabel "Prezzo del titolo"
set grid linewidth 2 linecolor "black"

set samples 1000

# Intervallo per l'asse x
set xrange [-5:10]

# Intervallo per l'asse y
set yrange [-0.1:1.6]

# Legenda
set key top left

## ------------------------------------------------------------------------
## definizione delle funzioni e delle costanti

log1p(x) = log (1.0 + x)
expm1(x) = exp (x) - 1.0
u(t)  = (t < 0.0)? 0.0 : 1.0
min(a,b) = (a<b)? b : a
max(a,b) = (a<b)? a : b

t0 = 0
t1 = 1
t2 = 2
t3 = 3
t4 = 4
t5 = 5

C1 = 0.03
C2 = 0.03
C3 = 0.03
C4 = 0.03
C5 = 0.03 + 1.0

U(t,L) = P * u(t - t0) * exp(L * (t - t0))
W(t,L) = \
  C1 * u(t - t1) * exp(L * (t - t1)) + \
  C2 * u(t - t2) * exp(L * (t - t2)) + \
  C3 * u(t - t3) * exp(L * (t - t3)) + \
  C4 * u(t - t4) * exp(L * (t - t4)) + \
  C5 * u(t - t5) * exp(L * (t - t5))

# Equazione d'attualizzazione.
P(etaperc) = \
  C1 * exp(expm1(etaperc / 100) * (t0 - t1)) + \
  C2 * exp(expm1(etaperc / 100) * (t0 - t2)) + \
  C3 * exp(expm1(etaperc / 100) * (t0 - t3)) + \
  C4 * exp(expm1(etaperc / 100) * (t0 - t4)) + \
  C5 * exp(expm1(etaperc / 100) * (t0 - t5))

## ------------------------------------------------------------------------

set linetype 1 linewidth 2.0 linecolor "blue"
set linetype 2 linewidth 2.0 linecolor "red"

# Plotta le funzioni
plot \
  P(t) title "Prezzo del titolo funzione dello {/:Italic Yield to Maturity}"

show output

### end of file
