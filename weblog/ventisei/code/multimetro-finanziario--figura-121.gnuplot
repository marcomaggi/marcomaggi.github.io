# multimetro-finanziario--figura-121.gnuplot --
#
# Per ottenere il file output in formato PNG eseguire al prompt d'una
# shell:
#
#    gnuplot -c multimetro-finanziario--figura-121.gnuplot
#
# Primo esempio d'inserzione a ponte: acquisto e liquidazione.
#

# Imposta il terminale per generare un'immagine PNG
set terminal pngcairo enhanced font 'arial,14' size 1000,600

# Nome del file di output
set output

# Titoli e etichette
set title "Calcolo del tasso interno di rendimento: acquisto e liquidazione, {/Symbol h} = 4,22719%"
set xlabel "tempo"
set ylabel "controvalore"
set grid linewidth 2 linecolor "black"
set samples 1000

# Intervallo per l'asse x
set xrange [-0.5:7]

# Intervallo per l'asse y
set yrange [-0.5:1.5]

# Legenda
set key top left

# Definizione delle funzioni e delle costanti

log1p(x) = log (1 + x)
expm1(x) = exp (x) - 1
min(a,b) = (a<b)? b : a
max(a,b) = (a<b)? a : b
u(t)     = (t < 0)? 0 : 1

Ltitolo		= log1p(0.05)

tm = 0
t0 = 1
t1 = 6

Cm = +1.0
C0 = -1.0
C1 = +1.23

U(t,L) = Cm * u(t - tm) * exp(L * (t - tm))

V(t,L) = U(t,L) + \
  + C0 * u(t - t0) * exp(L * (t - t0)) + \
  + C1 * u(t - t1) * exp(L * (t - t1))

## ------------------------------------------------------------------------

Lequ = - log(- C0 / C1) / (t1 - t0)
Nequ = 100 * expm1(Lequ)

print sprintf("Lequ = %f, Nequ = %f%%", Lequ, Nequ)

# Plotta le funzioni
plot \
  U(t,Lequ) linewidth 2.0 linecolor "red" \
     title "Controvalore U(t)", \
  \
  V(t,Lequ) linewidth 2.0 linecolor "blue" \
     title "Controvalore V(t)"

show output

### end of file
