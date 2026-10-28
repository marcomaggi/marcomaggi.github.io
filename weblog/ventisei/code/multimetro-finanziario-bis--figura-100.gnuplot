# multimetro-finanziario-bis--figura-100.gnuplot --
#
# Per ottenere il file output in formato PNG eseguire al prompt d'una
# shell:
#
#    gnuplot -c filename.gnuplot
#
# Visualizza il calcolo dello Yield to Maturity.
#

# Imposta il terminale per generare un'immagine PNG
set terminal pngcairo enhanced font 'arial,14' size 1000,600

# Nome del file di output
set output

# Titoli e etichette
set title "Calcolo dello {/:Italic Yield to Maturity} d'una obbligazione, {/Symbol h} = 7,60725%"
set xlabel "tempo"
set ylabel "valore"
set grid linewidth 2 linecolor "black"

set samples 1000

# Intervallo per l'asse x
set xrange [2:6]

# Intervallo per l'asse y
set yrange [-0.1:1.4]

# Legenda
set key top left

## ------------------------------------------------------------------------
## definizione delle funzioni e delle costanti

log1p(x) = log (1.0 + x)
expm1(x) = exp (x) - 1.0
u(t)  = (t < 0.0)? 0.0 : 1.0
min(a,b) = (a<b)? b : a
max(a,b) = (a<b)? a : b

tp = 2.3
t0 = 3
t1 = 4
t2 = 5
trimbo = 5

P = 0.9
Crimbo = 1.0
C0 = 0.03
C1 = 0.03
C2 = 0.03

U(t,L) = P * u(t - tp) * exp(L * (t - tp))
V(t,L) = \
  C0 * u(t - t0) * exp(L * (t - t0)) + \
  C1 * u(t - t1) * exp(L * (t - t1)) + \
  C2 * u(t - t2) * exp(L * (t - t2)) + \
  Crimbo* u(t - trimbo) * exp(L * (t - trimbo))

## ------------------------------------------------------------------------
## calcolo numerido di Lytd

# Definizione della funzione di cui trovare lo zero
Q(L) = - P + \
  C0 * exp(L * (- (t0 - tp))) + \
  C1 * exp(L * (- (t1 - tp))) + \
  C2 * exp(L * (- (t2 - tp))) + \
  Crimbo * exp(L * (- (trimbo - tp)))

# Intervallo iniziale [La, Lb] (deve soddisfare Q(La) * Q(Lb) < 0)
La = expm1(-20)
Lb = expm1(+20)

# Tolleranza per la convergenza
tolleranza = 1e-6

# Numero massimo di iterazioni
numbero_massimo_iterazioni = 100

# Verifica che Q(La) * Q(Lb) < 0
if (Q(La) * Q(Lb) >= 0) {
    print sprintf("Errore: Q(La)=%f e Q(Lb)=%f devono avere segni opposti.  Scegli un altro intervallo.", Q(La), Q(Lb))
    exit status 2
}

# Metodo di bisezione
print "Applico il metodo di bisezione per trovare lo zero di Q(L) in [", La, ", ", Lb, "]..."
print "Iterazione\t La\t\t Lb\t\t Lc\t\t Q(Lc)"

iter = 0
while ((Lb - La) > tolleranza && iter < numbero_massimo_iterazioni) {
    Lc = (La + Lb) / 2.0
    residuo = Q(Lc)
    print sprintf("%d\t\t %.6f\t %.6f\t %.6f\t %.6f", iter, La, Lb, Lc, residuo)
    if (residuo == 0) {
        print "Trovato zero esatto in L = ", Lc
        break
    } else {
       if (Q(La) * residuo < 0) {
         Lb = Lc  # Lo zero è in [La, Lc]
       } else {
         La = Lc  # Lo zero è in [Lc, Lb]
       }
    }
    iter = iter + 1
}

Lytm = Lc
Nytm = 100 * expm1(Lytm)

# Risultato finale
print "\nRisultato dopo ", iter, " iterazioni:"
print "Radice approssimata: Lytm = ", Lytm, ", Nytm = ", Nytm, "%"
print "Valore della funzione in Lytm = ", Lytm, ": Q(Lytm) = ", Q(Lytm)

## ------------------------------------------------------------------------

set linetype 1 linewidth 2.0 linecolor "blue"
set linetype 2 linewidth 2.0 linecolor "red"


# Plotta le funzioni
plot \
  V(t,Lytm) title "Controvalore V(t) investimento delle cedole e del rimborso incassati", \
  U(t,Lytm) title "Controvalore U(t) investimento del prezzo di vendita P"

show output

### end of file
