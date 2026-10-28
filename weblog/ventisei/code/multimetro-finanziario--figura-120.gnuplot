# multimetro-finanziario--figura-120.gnuplot --
#
# Per ottenere il file output in formato PNG eseguire al prompt d'una
# shell:
#
#    gnuplot -c multimetro-finanziario--figura-120.gnuplot
#
# Nel contesto dell'inserzione a ponte d'un multimetro: visualizza la
# risposta d'una combinazione lineare d'impulsi positivi e negativi.
#

# Imposta il terminale per generare un'immagine PNG
set terminal pngcairo enhanced font 'arial,14' size 1000,600

# Nome del file di output
set output

# Titoli e etichette
set title "Controvalore d'una combinazione lineare d'esponenziali per diversi valori di remunerazione"
set xlabel "tempo"
set ylabel "controvalore"
set grid linewidth 2 linecolor "black"

# Intervallo per l'asse x
set xrange [-0.5:13.0]

# Intervallo per l'asse y
set yrange [-0.5:4.2]

# Legenda
set key top left

# Definizione delle funzioni e delle costanti

log1p(x) = log (1 + x)
expm1(x) = exp (x) - 1
u(t) = (t < 0)? 0 : 1

Ltitolo		= log1p(0.05)

t0 = 1
t1 = 2.2
t2 = 3.2
t3 = 4.2
t4 = 5.2
t5 = 6.2
t6 = 7.2
t7 = 8.2
t8 = 9.2
t9 = 10.2

Cm = +1.0

C0 = -0.8
C1 = +0.3
C2 = +0.4
C3 = -0.23
C4 = +0.2
C5 = -0.5
C6 = +0.1
C7 = -0.2
C8 = +0.3
C9 = +0.8

U(t,L) = Cm * u(t - 0.0) * exp(L * (t - 0.0))

V(t,L) = Cm * u(t - 0.0) * exp(L * (t - 0.0)) + \
         C0 * u(t - t0) * exp(L * (t - t0)) + \
         C1 * u(t - t1) * exp(L * (t - t1)) + \
         C2 * u(t - t2) * exp(L * (t - t2)) + \
         C3 * u(t - t3) * exp(L * (t - t3)) + \
         C4 * u(t - t4) * exp(L * (t - t4)) + \
         C5 * u(t - t5) * exp(L * (t - t5)) + \
         C6 * u(t - t6) * exp(L * (t - t6)) + \
         C7 * u(t - t7) * exp(L * (t - t7)) + \
         C8 * u(t - t8) * exp(L * (t - t8)) + \
         C9 * u(t - t9) * exp(L * (t - t9))

## ------------------------------------------------------------------------

# Definizione della funzione di cui trovare lo zero
P(L) = C0 * exp(- L * (t0 - t0)) + \
       C1 * exp(- L * (t1 - t0)) + \
       C2 * exp(- L * (t2 - t0)) + \
       C3 * exp(- L * (t3 - t0)) + \
       C4 * exp(- L * (t4 - t0)) + \
       C5 * exp(- L * (t5 - t0)) + \
       C6 * exp(- L * (t6 - t0)) + \
       C7 * exp(- L * (t7 - t0)) + \
       C8 * exp(- L * (t8 - t0)) + \
       C9 * exp(- L * (t9 - t0))

# Helpers
min(a,b) = (a<b)? b : a
max(a,b) = (a<b)? a : b

# Intervallo iniziale [a, b] (deve soddisfare P(a) * P(b) < 0)
a = 0.001
b = 3.0

# Tolleranza per la convergenza
toll = 1e-6

# Numero massimo di iterazioni
max_iter = 100

# Verifica che f(a) * f(b) < 0
if (P(a) * P(b) >= 0) {
    print sprintf("Errore: P(a)=%f e P(b)=%f devono avere segni opposti. Scegli un altro intervallo.", P(a), P(b))
    exit status 2
}

# Metodo di bisezione
print "Applico il metodo di bisezione per trovare lo zero di P(x) in [", a, ", ", b, "]..."
print "Iterazione\t a\t\t b\t\t c\t\t P(c)"

iter = 0
while ((b - a) > toll && iter < max_iter) {
    c = (a + b) / 2.0
    fc = P(c)

    print sprintf("%d\t\t %.6f\t %.6f\t %.6f\t %.6f", iter, a, b, c, fc)

    if (fc == 0) {
        print "Trovato zero esatto in x = ", c
        break
    } else {
       if (P(a) * fc < 0) {
         b = c  # Lo zero è in [a, c]
       } else {
         a = c  # Lo zero è in [c, b]
       }
    }

    iter = iter + 1
}

Lequ = c
Nequ = 100 * expm1(Lequ)

# Risultato finale
print "\nRisultato dopo ", iter, " iterazioni:"
print "Radice approssimata: Lequ = ", Lequ, ", Nequ = ", Nequ, "%"
print "Valore della funzione in Lequ = ", Lequ, ": P(c) = ", P(Lequ)

## ------------------------------------------------------------------------

Na = -10.0
La = log1p(Na / 100.0)

Nb = 13.0
Lb = log1p(Nb / 100.0)

set linetype 1 linewidth 2.0 dashtype 10
set linetype 2 linewidth 2.0

set samples 1000

# Plotta le funzioni
plot \
  U(t,La) lt 1 linecolor "cyan" \
     title sprintf("Singolo impulso U(t), {/Symbol l} =  %+.4f", La), \
  \
  V(t,La) lt 2 linecolor "blue" \
     title sprintf("Movimentazione variegata V(t), {/Symbol l} =  %+.4f", La), \
  \
  \
  U(t,Lequ) lt 1 linecolor "magenta" \
     title sprintf("Singolo impulso U(t), {/Symbol l} =  %+.4f", Lequ), \
  \
  V(t,Lequ) lt 2 linecolor "red" \
     title sprintf("Movimentazione variegata V(t), {/Symbol l} =  %+.4f", Lequ), \
  \
  \
  U(t,Lb) lt 1 linecolor "green" \
     title sprintf("Singolo impulso U(t), {/Symbol l} =  %+.4f", Lb), \
  \
  V(t,Lb) lt 2 linecolor "dark-green" \
     title sprintf("Movimentazione variegata V(t), {/Symbol l} =  %+.4f", Lb)

show output

### end of file
