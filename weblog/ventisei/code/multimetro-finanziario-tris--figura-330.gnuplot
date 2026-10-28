# multimetro-finanziario-triss--figura-330.gnuplot --
#
# Per ottenere il file output in  formato PNG eseguire al prompt d'una
# shell:
#
#    gnuplot -c filename.gnuplot
#
# Prezzo   dell'obbligazioni   nella    prospettiva   del   potenziale
# acquirente:  esempio  acquistare/non-acquistare un'obbligazione  nel
# caso in cui sia conveniente astenersi dall'acquisto.
#

# Imposta il terminale per generare un'immagine PNG
set terminal pngcairo enhanced font 'arial,14' size 1000,600

# Nome del file di output
set output

# Titoli e etichette
set xlabel "tempo"
set ylabel "controvalore"
set grid linewidth 2 linecolor "black"

set samples 1000

# Intervallo per l'asse x
set xrange [-0.5:7]

# Intervallo per l'asse y
set yrange [-1.2:2.5]

# Legenda
set key top left

## ------------------------------------------------------------------------
## definizione delle funzioni e delle costanti

log1p(x) = log (1.0 + x)
expm1(x) = exp (x) - 1.0
u(t)     = (t < 0.0)? 0.0 : 1.0
min(a,b) = (a<b)? b : a
max(a,b) = (a<b)? a : b

Nbarf = 0.04
Lbarf = log1p(Nbarf)

t0 = 0
tp = 0.4
trimbo = 5
array tkappa[5]
tkappa[1] = 1
tkappa[2] = 2
tkappa[3] = 3
tkappa[4] = 4
tkappa[5] = 5

P  = 1.05
U0 = 1.23
Crimbo = 1.0
array Ckappa[5]
Ckappa[1] = 0.04
Ckappa[2] = 0.04
Ckappa[3] = 0.04
Ckappa[4] = 0.04
Ckappa[5] = 0.04

Vastiene(t) = 0
Uastiene(t) = U0 * u(t - t0) * exp(Lbarf * (t - t0)) + Vastiene(t)

Vcompra(t) = - P * u(t - tp) * exp(Lbarf * (t - tp)) + \
  Crimbo * u(t - trimbo) * exp(Lbarf * (t - trimbo)) + \
  (sum [k=1:5] Ckappa[k] * u(t - tkappa[k]) * exp(Lbarf * (t - tkappa[k])))

Ucompra(t) = Uastiene(t) + Vcompra(t)

## ------------------------------------------------------------------------
## calcolo numerido di Lytd

# Definizione della funzione di cui trovare lo zero
Qytm(L) = - P + \
  (sum [k=1:5] Ckappa[k] * exp(L * (- (tkappa[k] - tp)))) + \
  Crimbo * exp(L * (- (trimbo - tp)))

# Intervallo iniziale [La, Lb] (deve soddisfare Qytm(La) * Qytm(Lb) < 0)
La = -0.2
Lb = +0.1

# Tolleranza per la convergenza
tolleranza = 1e-6

# Numero massimo di iterazioni
numbero_massimo_iterazioni = 100

# Verifica che Qytm(La) * Qytm(Lb) < 0
if (Qytm(La) * Qytm(Lb) >= 0) {
    print sprintf("Errore: Qytm(La)=%f e Qytm(Lb)=%f devono avere segni opposti.  Scegli un altro intervallo.", Qytm(La), Qytm(Lb))
    exit status 2
}

# Metodo di bisezione
print "Applico il metodo di bisezione per trovare lo zero di Qytm(L) in [", La, ", ", Lb, "]..."
print "Iterazione\t La\t\t Lb\t\t Lc\t\t Qytm(Lc)"

Lc = 0
iter = 0
while ((Lb - La) > tolleranza && iter < numbero_massimo_iterazioni) {
    Lc = (La + Lb) / 2.0
    residuo = Qytm(Lc)
    print sprintf("%d\t\t %.6f\t %.6f\t %.6f\t %.6f", iter, La, Lb, Lc, residuo)
    if (residuo == 0) {
        print "Trovato zero esatto in L = ", Lc
        break
    } else {
       if (Qytm(La) * residuo < 0) {
         Lb = Lc  # Lo zero è in [La, Lc]
       } else {
         La = Lc  # Lo zero è in [Lc, Lb]
       }
    }
    iter = iter + 1
}

Lytm = Lc
Nytm = expm1(Lytm)

# Risultato finale
print "\nRisultato dopo ", iter, " iterazioni:"
print "Radice approssimata: Lytm = ", Lytm, ", Nytm = ", 100 * Nytm, "%"
print "Valore della funzione in Lytm = ", Lytm, ": Qytm(Lytm) = ", Qytm(Lytm)

## ------------------------------------------------------------------------

A = -P + \
  (sum [k=1:5] Ckappa[k] * exp(Lbarf * (tp - tkappa[k]))) + \
  Crimbo * exp(Lbarf * (tp - trimbo))

print sprintf("Portafoglio Barf Warlock: remunerazione Lbarf = %0.10f, rendimento Nbarf = %f%%", \
      Lbarf, 100 * Nbarf)
print sprintf("Prezzo, cedole e rimborso attualizzati a tp: A = %0.10f", A)
print sprintf("Controvalore V_{compra}(t_{rimborso}) = %0.10f", Vcompra(trimbo))
print sprintf("Controvalore V_{astiene}(t_{rimborso}) = %0.10f", Vastiene(trimbo))
print sprintf("Controvalore U_{compra}(t_{rimborso}) = %0.10f", Ucompra(trimbo))
print sprintf("Controvalore U_{astiene}(t_{rimborso}) = %0.10f", Uastiene(trimbo))

set title sprintf("Prezzo dell'obbligazioni, prospettiva del potenziale acquirente: meglio astenersi, {/:Italic {/Symbol h}_{ytm} = %0.2f%%}, {/:Italic {/Symbol h}_{barf} = %0.2f%%}", 100 * Nytm, 100 * Nbarf)

set linetype 1 linewidth 2.0 linecolor "blue"
set linetype 2 linewidth 2.0 linecolor "red"
set linetype 3 linewidth 2.0 linecolor "blue" dashtype 4
set linetype 4 linewidth 2.0 linecolor "red"  dashtype 4

# Plotta le funzioni
plot \
  Uastiene(t) title "Controvalore {/:Italic U_{astiene}(t)}", \
  Ucompra(t) title "Controvalore {/:Italic U_{compra}(t)}", \
  Vastiene(t) title "Controvalore {/:Italic V_{astiene}(t)}", \
  Vcompra(t) title "Controvalore {/:Italic V_{compra}(t)}"

show output

### end of file
