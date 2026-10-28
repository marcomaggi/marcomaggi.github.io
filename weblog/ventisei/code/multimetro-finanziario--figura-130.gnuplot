# multimetro-finanziario--figura-130.gnuplot --
#
# Per ottenere il file output in formato PNG eseguire al prompt d'una
# shell:
#
#    gnuplot -c multimetro-finanziario--figura-130.gnuplot
#
# Calcolo del rendimento effettivo per il BTp Tasso Fisso 4,75% 01
# Settembre 2044.
#

# Imposta il terminale per generare un'immagine PNG
set terminal pngcairo enhanced font 'arial,14' size 1000,600

# Nome del file di output
set output

# Titoli e etichette
set title "Inserzione a ponte del multimetro sul BTp Tasso Fisso 4,75% 01 Settembre 2044"
set xlabel "tempo"
set ylabel "controvalore"
set grid linewidth 2 linecolor "black"

# 2044.0 - 2026.0
numero_anni = 18
durata_semestre = 0.5

# Studiamo  il titolo  dal 18  settembre  2026 al  01 Settembre  2044,
# facendo corrispondere il 18 settembre 2026 all'istante t = 1.0.
#
# Il rimborso del titolo avviene il 2044-09-01, cioè dopo 18 anni
# finanziari meno 17 giorni dal decorso.
#
# Le cedole sono pagate il 20XX-03-01 e il 20XX-09-01.  Dal 20XX-09-01
# al 2026-09-18 ci sono 17 giorni, quindi nell'anno finanziario di 360
# giorni il primo pagamento di cedola avviene all'istante 17 / 360.
#
borsa_italiana_2026_09_18_prezzo_riferimento = 0.999
prezzo_acquisto = borsa_italiana_2026_09_18_prezzo_riferimento
istante_rimborso_dal_decorso = ((360.0 * 18.0) - 17.0) / 360.0
istante_primo_pagamento_cedola = durata_semestre - (17.0 / 360.0)

# Intervallo per l'asse x
set xrange [-0.5:(numero_anni + 3)]

# Intervallo per l'asse y
set yrange [-0.5:3.5]

# Legenda
set key top left

# Definizione delle funzioni e delle costanti

log1p(x) = log (1 + x)
expm1(x) = exp (x) - 1
u(t) = (t < 0)? 0 : 1

## ------------------------------------------------------------------------
## Risposta del multimetro all'impulso unitario

tm = 0
Cm = +1.0
U(t,L) = Cm * u(t - tm) * exp(L * (t - tm))

## ------------------------------------------------------------------------
## Movimenti di capitale

tmov0 = 1.0
tmov1 = tmov0 + istante_rimborso_dal_decorso
Cmov0 = - prezzo_acquisto
Cmov1 = +1.0
Vmov(t,L) = \
  Cmov0 * u(t - tmov0) * exp(L * (t - tmov0)) + \
  Cmov1 * u(t - tmov1) * exp(L * (t - tmov1))

## ------------------------------------------------------------------------
## Cedole pagate semestralmente

cedola_lorda_annuale    = 4.75 / 100
cedola_lorda_semestrale = cedola_lorda_annuale / 2.0
prima_cedola_lorda      = cedola_lorda_semestrale * (1.0 - 17.0 / 180.0)

tced0 = tmov0 + istante_primo_pagamento_cedola; # anno 0
tced1 = tced0 + durata_semestre
tced2 = tced1 + durata_semestre; # anno 1
tced3 = tced2 + durata_semestre
tced4 = tced3 + durata_semestre; # anno 2
tced5 = tced4 + durata_semestre
tced6 = tced5 + durata_semestre; # anno 3
tced7 = tced6 + durata_semestre
tced8 = tced7 + durata_semestre; # anno 4
tced9 = tced8 + durata_semestre
tced10 = tced9 + durata_semestre; # anno 5
tced11 = tced10 + durata_semestre
tced12 = tced11 + durata_semestre; # anno 6
tced13 = tced12 + durata_semestre
tced14 = tced13 + durata_semestre; # anno 7
tced15 = tced14 + durata_semestre
tced16 = tced15 + durata_semestre; # anno 8
tced17 = tced16 + durata_semestre
tced18 = tced17 + durata_semestre; # anno 9
tced19 = tced18 + durata_semestre
tced20 = tced19 + durata_semestre; # anno 10
tced21 = tced20 + durata_semestre
tced22 = tced21 + durata_semestre; # anno 11
tced23 = tced22 + durata_semestre
tced24 = tced23 + durata_semestre; # anno 12
tced25 = tced24 + durata_semestre
tced26 = tced25 + durata_semestre; # anno 13
tced27 = tced26 + durata_semestre
tced28 = tced27 + durata_semestre; # anno 14
tced29 = tced28 + durata_semestre
tced30 = tced29 + durata_semestre; # anno 15
tced31 = tced30 + durata_semestre
tced32 = tced31 + durata_semestre; # anno 16
tced33 = tced32 + durata_semestre
tced34 = tced33 + durata_semestre; # anno 17
tced35 = tced34 + durata_semestre

Cced0 = prima_cedola_lorda
Cced1 = cedola_lorda_semestrale
Cced2 = cedola_lorda_semestrale
Cced3 = cedola_lorda_semestrale
Cced4 = cedola_lorda_semestrale
Cced5 = cedola_lorda_semestrale
Cced6 = cedola_lorda_semestrale
Cced7 = cedola_lorda_semestrale
Cced8 = cedola_lorda_semestrale
Cced9 = cedola_lorda_semestrale
Cced10 = cedola_lorda_semestrale
Cced11 = cedola_lorda_semestrale
Cced12 = cedola_lorda_semestrale
Cced13 = cedola_lorda_semestrale
Cced14 = cedola_lorda_semestrale
Cced15 = cedola_lorda_semestrale
Cced16 = cedola_lorda_semestrale
Cced17 = cedola_lorda_semestrale
Cced18 = cedola_lorda_semestrale
Cced19 = cedola_lorda_semestrale
Cced20 = cedola_lorda_semestrale
Cced21 = cedola_lorda_semestrale
Cced22 = cedola_lorda_semestrale
Cced23 = cedola_lorda_semestrale
Cced24 = cedola_lorda_semestrale
Cced25 = cedola_lorda_semestrale
Cced26 = cedola_lorda_semestrale
Cced27 = cedola_lorda_semestrale
Cced28 = cedola_lorda_semestrale
Cced29 = cedola_lorda_semestrale
Cced30 = cedola_lorda_semestrale
Cced31 = cedola_lorda_semestrale
Cced32 = cedola_lorda_semestrale
Cced33 = cedola_lorda_semestrale
Cced34 = cedola_lorda_semestrale
Cced35 = cedola_lorda_semestrale

Vced(t,L) = \
  Cced0 * u(t - tced0) * exp(L * (t - tced0)) + \
  Cced1 * u(t - tced1) * exp(L * (t - tced1)) + \
  Cced2 * u(t - tced2) * exp(L * (t - tced2)) + \
  Cced3 * u(t - tced3) * exp(L * (t - tced3)) + \
  Cced4 * u(t - tced4) * exp(L * (t - tced4)) + \
  Cced5 * u(t - tced5) * exp(L * (t - tced5)) + \
  Cced6 * u(t - tced6) * exp(L * (t - tced6)) + \
  Cced7 * u(t - tced7) * exp(L * (t - tced7)) + \
  Cced8 * u(t - tced8) * exp(L * (t - tced8)) + \
  Cced9 * u(t - tced9) * exp(L * (t - tced9)) + \
  Cced10 * u(t - tced10) * exp(L * (t - tced10)) + \
  Cced11 * u(t - tced11) * exp(L * (t - tced11)) + \
  Cced12 * u(t - tced12) * exp(L * (t - tced12)) + \
  Cced13 * u(t - tced13) * exp(L * (t - tced13)) + \
  Cced14 * u(t - tced14) * exp(L * (t - tced14)) + \
  Cced15 * u(t - tced15) * exp(L * (t - tced15)) + \
  Cced16 * u(t - tced16) * exp(L * (t - tced16)) + \
  Cced17 * u(t - tced17) * exp(L * (t - tced17)) + \
  Cced18 * u(t - tced18) * exp(L * (t - tced18)) + \
  Cced19 * u(t - tced19) * exp(L * (t - tced19)) + \
  Cced20 * u(t - tced20) * exp(L * (t - tced20)) + \
  Cced21 * u(t - tced21) * exp(L * (t - tced21)) + \
  Cced22 * u(t - tced22) * exp(L * (t - tced22)) + \
  Cced23 * u(t - tced23) * exp(L * (t - tced23)) + \
  Cced24 * u(t - tced24) * exp(L * (t - tced24)) + \
  Cced25 * u(t - tced25) * exp(L * (t - tced25)) + \
  Cced26 * u(t - tced26) * exp(L * (t - tced26)) + \
  Cced27 * u(t - tced27) * exp(L * (t - tced27)) + \
  Cced28 * u(t - tced28) * exp(L * (t - tced28)) + \
  Cced29 * u(t - tced29) * exp(L * (t - tced29)) + \
  Cced30 * u(t - tced30) * exp(L * (t - tced30)) + \
  Cced31 * u(t - tced31) * exp(L * (t - tced31)) + \
  Cced32 * u(t - tced32) * exp(L * (t - tced32)) + \
  Cced33 * u(t - tced33) * exp(L * (t - tced33)) + \
  Cced34 * u(t - tced34) * exp(L * (t - tced34)) + \
  Cced35 * u(t - tced35) * exp(L * (t - tced35))

## ------------------------------------------------------------------------
## Tassazione cedole e reddito finanziario

# tasse sul reddito
Vtassereddito(t,L) = - 0.125 * (Cmov1 + Cmov0) * u(t - tmov1) * exp(L * (t - tmov1))

# tasse cedole
Vtasseced(t,L) = - 0.125 * Vced(t,L)

## ------------------------------------------------------------------------

Vlordo(t,L) = U(t,L) + Vmov(t,L) + Vced(t,L)
Vnetto(t,L) = Vlordo(t,L) + Vtassereddito(t, L) + Vtasseced(t,L)

## ------------------------------------------------------------------------
## Calcolo remunerazione lorda

# Definizione della funzione di cui trovare lo zero
Plordo(L) = Vmov(tmov1,L) + Vced(tmov1,L)

# Helpers
min(a,b) = (a<b)? b : a
max(a,b) = (a<b)? a : b

# Intervallo iniziale [a, b] (deve soddisfare Plordo(a) * Plordo(b) < 0)
a = 0.001
b = 3.0

# Tolleranza per la convergenza
toll = 1e-6

# Numero massimo di iterazioni
max_iter = 100

# Verifica che f(a) * f(b) < 0
if (Plordo(a) * Plordo(b) >= 0) {
    print sprintf("Errore: Plordo(a)=%f e Plordo(b)=%f devono avere segni opposti. Scegli un altro intervallo.", Plordo(a), Plordo(b))
    exit status 2
}

# Metodo di bisezione
print "Applico il metodo di bisezione per trovare lo zero di Plordo(x) in [", a, ", ", b, "]..."
print "Iterazione\t a\t\t b\t\t c\t\t Plordo(c)"

iter = 0
while ((b - a) > toll && iter < max_iter) {
    c = (a + b) / 2.0
    fc = Plordo(c)

    print sprintf("%d\t\t %.6f\t %.6f\t %.6f\t %.6f", iter, a, b, c, fc)

    if (fc == 0) {
        print "Trovato zero esatto in x = ", c
        break
    } else {
       if (Plordo(a) * fc < 0) {
         b = c  # Lo zero è in [a, c]
       } else {
         a = c  # Lo zero è in [c, b]
       }
    }

    iter = iter + 1
}

Lequlordo = c
Nequlordo = 100 * expm1(Lequlordo)

# Risultato finale
print "\nRisultato dopo ", iter, " iterazioni:"
print "Radice approssimata: Lequlordo = ", Lequlordo, ", Nequlordo = ", Nequlordo, "%"
print "Valore della funzione in Lequlordo = ", Lequlordo, ": Plordo(c) = ", Plordo(Lequlordo)

## ------------------------------------------------------------------------
## Calcolo remunerazione netta

# Definizione della funzione di cui trovare lo zero
Pnetto(L) = Vmov(tmov1,L) + Vced(tmov1,L) + Vtassereddito(tmov1, L) + Vtasseced(tmov1,L)

# Helpers
min(a,b) = (a<b)? b : a
max(a,b) = (a<b)? a : b

# Intervallo iniziale [a, b] (deve soddisfare Pnetto(a) * Pnetto(b) < 0)
a = 0.001
b = 3.0

# Tolleranza per la convergenza
toll = 1e-6

# Numero massimo di iterazioni
max_iter = 100

# Verifica che f(a) * f(b) < 0
if (Pnetto(a) * Pnetto(b) >= 0) {
    print sprintf("Errore: Pnetto(a)=%f e Pnetto(b)=%f devono avere segni opposti. Scegli un altro intervallo.", Pnetto(a), Pnetto(b))
    exit status 2
}

# Metodo di bisezione
print "Applico il metodo di bisezione per trovare lo zero di Pnetto(x) in [", a, ", ", b, "]..."
print "Iterazione\t a\t\t b\t\t c\t\t Pnetto(c)"

iter = 0
while ((b - a) > toll && iter < max_iter) {
    c = (a + b) / 2.0
    fc = Pnetto(c)

    print sprintf("%d\t\t %.6f\t %.6f\t %.6f\t %.6f", iter, a, b, c, fc)

    if (fc == 0) {
        print "Trovato zero esatto in x = ", c
        break
    } else {
       if (Pnetto(a) * fc < 0) {
         b = c  # Lo zero è in [a, c]
       } else {
         a = c  # Lo zero è in [c, b]
       }
    }

    iter = iter + 1
}

Lequnetto = c
Nequnetto = 100 * expm1(Lequnetto)

# Risultato finale
print "\nRisultato dopo ", iter, " iterazioni:"
print "Radice approssimata: Lequnetto = ", Lequnetto, ", Nequnetto = ", Nequnetto, "%"
print "Valore della funzione in Lequnetto = ", Lequnetto, ": Pnetto(c) = ", Pnetto(Lequnetto)

## ------------------------------------------------------------------------

Na = -5.0
La = log1p(Na / 100.0)

Nb = 11.0
Lb = log1p(Nb / 100.0)

set linetype 1 linewidth 2.0
set linetype 2 linewidth 2.0
set linetype 3 linewidth 2.0 linecolor "red"
set linetype 4 linewidth 2.0 linecolor "gold"

set samples 1000

# Plotta le funzioni
plot \
  U(t,Lequlordo) \
     title sprintf("Singolo impulso, remunerazione lorda %+.5f", Lequlordo), \
  \
  Vlordo(t,Lequlordo) \
     title sprintf("Controvalore BTp, remunerazione lorda %+.5f, rendimento lordo %+.4f%%", \
                   Lequlordo, Nequlordo), \
  \
  U(t,Lequnetto) \
     title sprintf("Singolo impulso, remunerazione netta %+.5f", Lequnetto), \
  \
  Vnetto(t,Lequnetto) \
     title sprintf("Controvalore BTp, remunerazione netta %+.5f, rendimento netto %+.4f%%", \
                   Lequnetto, Nequnetto)

show output

### end of file
