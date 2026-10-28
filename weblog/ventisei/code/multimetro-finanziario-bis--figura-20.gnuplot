# multimetro-finanziario-bis--figura-20.gnuplot --
#
# Per ottenere il file output in formato PNG eseguire al prompt d'una
# shell:
#
#    gnuplot -c filename.gnuplot
#
# Visualizza i controvalori associati a reinvestimento in
# obbligazioni, con cash drag.
#

# Imposta il terminale per generare un'immagine PNG
set terminal pngcairo enhanced font 'arial,14' size 1000,600

# Nome del file di output
set output

# Titoli e etichette
set title "Investimento e reinvestimento in obbligazioni"
set xlabel "tempo"
set ylabel "valore"
set grid linewidth 2 linecolor "black"

set samples 1000

# Intervallo per l'asse x
set xrange [-0.5:7.0]

# Intervallo per l'asse y
set yrange [-0.1:1.7]

# Legenda
set key top left

# Definizione delle funzioni e delle costanti

log1p(x) = log (1.0 + x)
expm1(x) = exp (x) - 1.0
u(t)  = (t < 0.0)? 0.0 : 1.0

t0 =   0.0
t1 =   1.0
t2 =   2.0
t3 =   3.0
t4 =   4.0
t5 =   5.0
t6 =   6.0

C0 = 0.95
C1 = 0.93
C2 = 1.05
C3 = 0.92
C4 = 0.96
C5 = 0.91

Ccompenso = 0.1

L0 = - log(C0)
L1 = - log(C1)
L2 = - log(C2)
L3 = - log(C3)
L4 = - log(C4)
L5 = - log(C5)
L6 = 0.0

print sprintf("N0 = %+.4f%%", 100 * expm1(L0))
print sprintf("N1 = %+.4f%%", 100 * expm1(L1))
print sprintf("N2 = %+.4f%%", 100 * expm1(L2))
print sprintf("N3 = %+.4f%%", 100 * expm1(L3))
print sprintf("N4 = %+.4f%%", 100 * expm1(L4))
print sprintf("N5 = %+.4f%%", 100 * expm1(L5))

U(t) = \
  C0 * u(t - t0) * exp(L0 * (t - t0)) + \
  -1 * u(t - t1) * exp(L0 * (t - t1)) + \
  C1 * u(t - t1) * exp(L1 * (t - t1)) + \
  -1 * u(t - t2) * exp(L1 * (t - t2)) + \
  C2 * u(t - t2) * exp(L2 * (t - t2)) + \
  -1 * u(t - t3) * exp(L2 * (t - t3)) + \
  C3 * u(t - t3) * exp(L3 * (t - t3)) + \
  -1 * u(t - t4) * exp(L3 * (t - t4)) + \
  C4 * u(t - t4) * exp(L4 * (t - t4)) + \
  -1 * u(t - t5) * exp(L4 * (t - t5)) + \
  C5 * u(t - t5) * exp(L5 * (t - t5)) + \
  -1 * u(t - t6) * exp(L5 * (t - t6))

Ucompenso(t) = \
  (1 - u(t)) + \
  (1 - C0) * u(t - t0) + \
  (1 - C1) * u(t - t1) + \
  (1 - C2) * u(t - t2) + \
  (1 - C3) * u(t - t3) + \
  (1 - C4) * u(t - t4) + \
  (1 - C5) * u(t - t5) + \
             u(t - t6)

Utotale(t) = U(t) + Ucompenso(t)

Ltotale    = (log(Utotale(t6)) - log(Utotale(t0))) / (t6 - t0)
Ntotale    = 100.0 * expm1(Ltotale)

print sprintf("U(%d - 1e-6) = %+.4f", t6, U(t6 - 1e-6));
print sprintf("Utotale(%d) = %+.4f, Utotale(%d) = %+.4f, Ltotale = %+.4f, Ntotale = %+.4f%%", \
      t0, Utotale(t0), t6, Utotale(t6), Ltotale, Ntotale);

set linetype 1 linewidth 2.0 linecolor "red"
set linetype 2 linewidth 2.0 linecolor "blue"
set linetype 3 linewidth 2.0 linecolor "dark-green"

# Plotta le funzioni
plot \
  U(t)		title "Controvalore investimento e reinvestimento", \
  Ucompenso(t)	title "Controvalore compensazione", \
  Utotale(t)	title "Controvalore totale"

show output

### end of file
