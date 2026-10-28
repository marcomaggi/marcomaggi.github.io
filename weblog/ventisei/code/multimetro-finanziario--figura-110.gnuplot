# multimetro-finanziario--figura-110.gnuplot --
#
# Per ottenere il file output in formato PNG eseguire al prompt d'una
# shell:
#
#    gnuplot -c multimetro-finanziario--figura-110.gnuplot
#
# Visualizza il valore al netto delle tasse d'un investimento di
# capitale in un titolo finanziario.
#

# Imposta il terminale per generare un'immagine PNG
set terminal pngcairo enhanced font 'arial,14' size 1000,600

# Nome del file di output
set output

# Titoli e etichette
set title "Svalutazione d'un investimento di capitale dovuta alla tassazione del reddito finanziario al 26%"
set xlabel "tempo"
set ylabel "controvalore"
set grid linewidth 2 linecolor "black"

set samples 1000

# Intervallo per l'asse x
set xrange [-0.5:10.5]

# Intervallo per l'asse y
set yrange [0:180]

# Legenda
set key top left

# Definizione delle funzioni e delle costanti

log1p(x) = log (1 + x)
u(t) = (t < 0)? 0 : 1

Ltitolo		= log1p(0.05)
Lcosto		= log1p(- 0.0123)

C0 = +100
t0 = 0
t1 = 10

Ulordo(t)	= C0 * u(t - t0) * exp(Ltitolo * (t - t0))
tax(t)		= 0.26 * (Ulordo(t) - C0) * u(Ulordo(t) - C0)
Unettodiffe(t)	= Ulordo(t) - tax(t)

Ltax(t)         = log(1 - tax(t) / Ulordo(t)) / (t - t0)
Unettolambda(t) = C0 * u(t - t0) * exp((Ltitolo + Ltax(t)) * (t - t0))

# Plotta le funzioni
plot Ulordo(t) with lines linewidth 2 \
     title "Controvalore lordo dell'investimento, rendimento effettivo 5%", \
     \
     Unettodiffe(t) with lines linewidth 2 linecolor "red" \
     title "Controvalore netto dell'investimento, calcolo come differenza", \
     \
     Unettolambda(t) with lines linewidth 2 dashtype 10 linecolor "black" \
     title "Controvalore netto dell'investimento, calcolo come esponenziale"

show output

### end of file
