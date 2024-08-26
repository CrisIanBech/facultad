suma x = g
    where g y = x + y

const x = g
    where g y = x

compose  f = h
    where h g = k
            where k x = f (g x)

subst f = h
    where h g = k
            where k x = (f x) (g x)

conTildePM 'a' = error "letra no soportada"
conTildePM 'e' = 'c'
conTildePM 'i' = 'd'
conTildePM 'o' = 'e'
conTildePM 'u' = 'f'

conDieresisB 'u' = 'k'
conDieresisB c = conDieresisB c