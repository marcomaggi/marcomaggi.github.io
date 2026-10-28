# multimetro-finanziario-tris--figura-100.gnuplot --
#
# Per ottenere il file output in  formato PNG eseguire al prompt d'una
# shell:
#
#    gnuplot -c filename.gnuplot >output.png
#
# Visualizza i controvalori associati  a reinvestimento in BOT annuali
# e cash drag.
#

# Imposta il terminale per generare un'immagine PNG
set terminal pngcairo enhanced font 'arial,14' size 1000,600

# Scrive il file png in stdout.
set output

# Titoli e etichette
set title "Investimento e reinvestimento in BoT, singola linea"
set xlabel "tempo"
set ylabel "valore"
set grid linewidth 2 linecolor "black"

set samples 1000

# Intervallo per l'asse x
set xrange [-0.5:11.0]

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
t7 =   7.0
t8 =   8.0
t9 =   9.0
t10 = 10.0

Cacq = 0.98
Crim = 1.0

Ccompenso = 1.0

L = - log(Cacq)

U(t) = \
    Cacq * u(t - t0) * exp(L * (t - t0)) + \
  - Crim * u(t - t1) * exp(L * (t - t1)) + \
    Cacq * u(t - t1) * exp(L * (t - t1)) + \
  - Crim * u(t - t2) * exp(L * (t - t2)) + \
    Cacq * u(t - t2) * exp(L * (t - t2)) + \
  - Crim * u(t - t3) * exp(L * (t - t3)) + \
    Cacq * u(t - t3) * exp(L * (t - t3)) + \
  - Crim * u(t - t4) * exp(L * (t - t4)) + \
    Cacq * u(t - t4) * exp(L * (t - t4)) + \
  - Crim * u(t - t5) * exp(L * (t - t5)) + \
    Cacq * u(t - t5) * exp(L * (t - t5)) + \
  - Crim * u(t - t6) * exp(L * (t - t6)) + \
    Cacq * u(t - t6) * exp(L * (t - t6)) + \
  - Crim * u(t - t7) * exp(L * (t - t7)) + \
    Cacq * u(t - t7) * exp(L * (t - t7)) + \
  - Crim * u(t - t8) * exp(L * (t - t8)) + \
    Cacq * u(t - t8) * exp(L * (t - t8)) + \
  - Crim * u(t - t9) * exp(L * (t - t9)) + \
    Cacq * u(t - t9) * exp(L * (t - t9)) + \
  - Crim * u(t - t10) * exp(L * (t - t10))

Ucompenso(t) = \
  (1 - u(t - t0) + u(t - t10)) + \
  (1 - Cacq) * u(t - t0) + \
  (1 - Cacq) * u(t - t1) + \
  (1 - Cacq) * u(t - t2) + \
  (1 - Cacq) * u(t - t3) + \
  (1 - Cacq) * u(t - t4) + \
  (1 - Cacq) * u(t - t5) + \
  (1 - Cacq) * u(t - t6) + \
  (1 - Cacq) * u(t - t7) + \
  (1 - Cacq) * u(t - t8) + \
  (1 - Cacq) * u(t - t9)

Utotale(t) = U(t) + Ucompenso(t)

Ltotale    = (log(Utotale(t10)) - log(Utotale(t0))) / (t10 - t0)
Ntotale    = 100.0 * expm1(Ltotale)

print sprintf("Lsingolo = %+.4f, Nsingolo = %+.4f%", L, 100.0 * expm1(L));
print sprintf("U(%d - 1e-6) = %+.4f", t10, U(t10 - 1e-6));
print sprintf("Utotale(%d) = %+.4f, Utotale(%d) = %+.4f, Ltotale = %+.4f, Ntotale = %+.4f%%", \
      t0, Utotale(t0), t10, Utotale(t10), Ltotale, Ntotale);

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
