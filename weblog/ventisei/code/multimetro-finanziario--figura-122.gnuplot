# multimetro-finanziario--figura-122.gnuplot --
#
# Per ottenere il file output in formato PNG eseguire al prompt d'una
# shell:
#
#    gnuplot -c multimetro-finanziario--figura-122.gnuplot
#
# Secondo esempio d'inserzione a ponte: acquisto, dividendi e liquidazione.
#

# Imposta il terminale per generare un'immagine PNG
set terminal pngcairo enhanced font 'arial,14' size 1000,600

# Nome del file di output
set output

# Titoli e etichette
set title "Calcolo del tasso interno di rendimento: acquisto, dividendi e liquidazione, {/Symbol h} = 9,42107%"
set xlabel "tempo"
set ylabel "controvalore"
set grid linewidth 2 linecolor "black"
set samples 1000

# Intervallo per l'asse x
set xrange [-0.5:7]

# Intervallo per l'asse y
set yrange [-0.5:2]

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
t1 = 4
t2 = 5
t3 = 6

Cm = +1.0
C0 = -1.0
C1 = +0.1
C2 = +0.2
C3 = +1.23

U(t,L) = Cm * u(t - tm) * exp(L * (t - tm))

V(t,L) = U(t,L) + \
  + C0 * u(t - t0) * exp(L * (t - t0)) + \
  + C1 * u(t - t1) * exp(L * (t - t1)) + \
  + C2 * u(t - t2) * exp(L * (t - t2)) + \
  + C3 * u(t - t3) * exp(L * (t - t3))

## ------------------------------------------------------------------------
## Metodo della bisezione per il calcolo della remunerazione d'equilibrio

# Definizione della funzione di cui trovare lo zero
P(L) = \
  + C0 * exp(L * (- (t0 - t0))) + \
  + C1 * exp(L * (- (t1 - t0))) + \
  + C2 * exp(L * (- (t2 - t0))) + \
  + C3 * exp(L * (- (t3 - t0)))

# Intervallo iniziale [La, Lb] (deve soddisfare P(La) * P(Lb) < 0)
La = 0.001
Lb = 3.0

# Tolleranza per la convergenza
tolleranza = 1e-6

# Numero massimo di iterazioni
numero_massimo_iterazioni = 100

# Verifica che f(a) * f(b) < 0
if (P(La) * P(Lb) >= 0) {
    print sprintf("Errore: P(La)=%f e P(Lb)=%f devono avere segni opposti.  Scegli un altro intervallo.", P(La), P(Lb))
    exit status 2
}

# Metodo di bisezione
print "Applico il metodo di bisezione per trovare lo zero di P(L) in [", La, ", ", Lb, "]..."
print "Iterazione\t La\t\t Lb\t\t Lc\t\t P(Lc)"

iter = 0
while ((Lb - La) > tolleranza && iter < numero_massimo_iterazioni) {
    Lc = (La + Lb) / 2.0
    fc = P(Lc)
    print sprintf("%d\t\t %.6f\t %.6f\t %.6f\t %.6f", iter, La, Lb, Lc, fc)
    if (fc == 0) {
        print "Trovato zero esatto in Lc = ", Lc
        break
    } else {
       if (P(La) * fc < 0) {
         Lb = Lc  # Lo zero è in [La, Lc]
       } else {
         La = Lc  # Lo zero è in [Lc, Lb]
       }
    }
    iter = iter + 1
}

Lequ = Lc
Nequ = 100 * expm1(Lequ)

# Risultato finale
print "\nRisultato dopo ", iter, " iterazioni:"
print "Radice approssimata: Lequ = ", Lequ, ", Nequ = ", Nequ, "%"
print "Valore della funzione in Lequ = ", Lequ, ": P(Lequ) = ", P(Lequ)

## ------------------------------------------------------------------------
# Plotta le funzioni
plot \
  U(t,Lequ) linewidth 2.0 linecolor "red" \
     title "Controvalore U(t)", \
  \
  V(t,Lequ) linewidth 2.0 linecolor "blue" \
     title "Controvalore V(t)"

show output

### end of file
