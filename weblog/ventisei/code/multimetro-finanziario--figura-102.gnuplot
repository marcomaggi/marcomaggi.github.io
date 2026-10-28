# multimetro-finanziario--figura-102.gnuplot --
#
# Per ottenere il file output in formato PNG eseguire al prompt d'una
# shell:
#
#    gnuplot -c multimetro-finanziario--figura-102.gnuplot
#
# Funzione  costo totale  addebitato all'istante  t con  distribuzione
# esponenziale, confronto con il costo annuale addebitato a fine anno.
#

# Imposta il terminale per generare un'immagine PNG
set terminal pngcairo enhanced font 'arial,14' size 1000,600

# Nome del file di output
set output

# Titoli e etichette
set title "Accumulo esponenziale {/:Italic ongoing charges}, confronto con accumulo a impulsi, {/Symbol h} = 4%, O = 3%"
set xlabel "tempo"
set ylabel "controvalore"
set grid linewidth 2 linecolor "black"

set samples 1000

# Intervallo per l'asse x
set xrange [-0.5:10.5]

# Intervallo per l'asse y
set yrange [-0.05:0.4]

# Legenda
set key top left

# Definizione delle funzioni e delle costanti

log1p(x) = log (1 + x)
u(t) = (t < 0)? 0 : 1

N = 0.04
L = log1p(N)
O = 0.03
omega = O * N / L
# gamma = omega / N = (O * N / L) / N = O / L
gamma = O / L

C0 = 1
t0 = 0
t1 = 1
t2 = 2
t3 = 3
t4 = 4
t5 = 5
t6 = 6
t7 = 7
t8 = 8
t9 = 9
t10 = 10

U(t)		= C0 * u(t - t0) * exp(L * (t - t0))
Uimpulso(t)	= \
  U(t0) * omega * u(t - (t0 + 1)) + \
  U(t1) * omega * u(t - (t1 + 1)) + \
  U(t2) * omega * u(t - (t2 + 1)) + \
  U(t3) * omega * u(t - (t3 + 1)) + \
  U(t4) * omega * u(t - (t4 + 1)) + \
  U(t5) * omega * u(t - (t5 + 1)) + \
  U(t6) * omega * u(t - (t6 + 1)) + \
  U(t7) * omega * u(t - (t7 + 1)) + \
  U(t8) * omega * u(t - (t8 + 1)) + \
  U(t9) * omega * u(t - (t9 + 1)) + \
  U(t10) * omega * u(t - (t10 + 1))

Uespo(t) = gamma * C0 * u(t - t0) * (exp(L * (t - t0)) - 1)

# Plotta le funzioni
plot Uimpulso(t) with lines linewidth 2 linecolor "red" \
     title "Accumulo {/:Italic ongoing charges} con impulsi a fine anno", \
     \
     Uespo(t) with lines linewidth 2 linecolor "dark-green" \
     title "Accumulo {/:Italic ongoing charges} con distribuzione esponenziale"

show output

### end of file
