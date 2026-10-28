# multimetro-finanziario--figura-105.gnuplot --
#
# Per ottenere il file output in formato PNG eseguire al prompt d'una
# shell:
#
#    gnuplot -c multimetro-finanziario--figura-105.gnuplot
#
# Visualizza il valore al netto delle ongoing charges esponenziali
# d'un investimento di capitale.
#

# Imposta il terminale per generare un'immagine PNG
set terminal pngcairo enhanced font 'arial,14' size 1000,600

# Nome del file di output
set output

# Titoli e etichette
set title "Drenaggio di valore dovuto alle {/:Italic ongoing charges} esponenziali"
set xlabel "tempo"
set ylabel "controvalore"
set grid linewidth 2 linecolor "black"

set samples 1000

# Intervallo per l'asse x
set xrange [-0.5:10]

# Intervallo per l'asse y
set yrange [0:1.7]

# Legenda
set key top left

# Definizione delle funzioni e delle costanti

log1p(x) = log (1 + x)
u(t) = (t < 0)? 0 : 1

N = 0.04
L = log1p(N)
O = 0.03
omega = O * N / L
gamma = O / L

C0 = 1
t0 = 0
t1 = 1

U(t)		= C0 * u(t - t0) * exp(L * (t - t0))
Ucostoespo(t)	= gamma * C0 * u(t - t0) * (exp(L * (t - t0)) - 1)
Unetto(t)	= U(t) - Ucostoespo(t)

# Plotta le funzioni
plot U(t)  with lines linewidth 2 \
     title "Controvalore dell'investimento, rendimento effettivo {/Symbol h} = 4%", \
     \
     Ucostoespo(t)   with lines linewidth 2 linecolor "red" \
     title "{/:Italic Ongoing charges} con distribuzione esponenziale, O = 3%", \
     \
     Unetto(t)   with lines linewidth 2 linecolor "dark-green" \
     title "Controvalore al netto delle {/:Italic ongoing charges}"

show output

### end of file
