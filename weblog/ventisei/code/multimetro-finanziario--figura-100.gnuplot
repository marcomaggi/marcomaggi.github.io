# multimetro-finanziario--figura-100.gnuplot --
#
# Per ottenere il file output in  formato PNG eseguire al prompt d'una
# shell:
#
#    gnuplot -c multimetro-finanziario--figura-100.gnuplot
#
# Visualizza  il  valore  al  netto dei  costi  d'un  investimento  di
# capitale in un titolo finanziario.
#

# Imposta il terminale per generare un'immagine PNG
set terminal pngcairo enhanced font 'arial,14' size 1000,600

# Nome del file di output
set output

# Titoli e etichette
set title "Calcolo del valore medio d'un esponenziale anno per anno"
set xlabel "tempo"
set ylabel "controvalore"
set grid linewidth 2 linecolor "black"

set samples 1000

# Intervallo per l'asse x
set xrange [-0.5:3.5]

# Intervallo per l'asse y
set yrange [0.95:1.15]

# Legenda
set key top left

# Definizione delle funzioni e delle costanti

log1p(x) = log (1 + x)
u(t) = (t < 0)? 0 : 1

Nperc = 4.0
N = Nperc / 100.0
L = log1p(N)
omega = N / L

C0 = 1
t0 = 0
t1 = 1
t2 = 2
t3 = 3
t4 = 4

U(t)		= C0 * u(t - t0) * exp(L * (t - t0))
Umedio(t)	= \
  omega * U(t0) * (u(t - t0) - u(t - t1)) + \
  omega * U(t1) * (u(t - t1) - u(t - t2)) + \
  omega * U(t2) * (u(t - t2) - u(t - t3)) + \
  omega * U(t3) * (u(t - t3) - u(t - t4))

# Plotta le funzioni
plot U(t)  with lines linewidth 2 \
     title sprintf("Esponenziale con tasso annuale %d%%", Nperc), \
     \
     Umedio(t)   with lines linewidth 2 linecolor "red" \
     title "Valor medio dell'esponenziale anno per anno"

show output

### end of file
