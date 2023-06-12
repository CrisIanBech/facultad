data AppList a = Single a
| Append (AppList a) (AppList a)

lenAL :: AppList a -> Int
lenAL (Single l) = 1
lenAL (Append apl1 apl2) = lenAl apl1 + lenAl apl2

consAL :: a -> AppList a -> AppList a
consAL e (Single l) = appendToElement e l
consAl e (Append apl1 apl2) = Append (consAL e apl1) apl2

appendToElement :: a -> a -> AppList a
appendToElement e l = Append (Single e) (Single l)

headAL :: AppList a -> a
headAL (Single e) = e
headAL (Append apl1 apl2) = headAL apl1

tailAL :: AppList a -> AppList a
tailAL (Append apl1 apl2) = sacarPrimeroSiSingle (tailAL apl1) (tailAl apl2)

sacarPrimeroSiSingle :: AppList a -> AppList a -> AppList a
sacarPrimeroSiSingle (Single e) appL = appL
sacarPrimeroSiSingle appL1 appL2 = Append appL1 appL2

snocAL :: a -> AppList a -> AppList a
snocAL e (Single el) = Append (Single e) (Single el) 
snocAL e (Append apL1 apL2) = Append apL1 (snocAL e apL2)

lastAL :: AppList a -> a
lastAL (Single el) = el
lastAL (Append apL1 apL2) = lastAl apL2

initAL :: AppList a -> AppList a
initAL (Append apL1 apL2) = sacarSegundoSiSingle apL1 apL2

sacarSegundoSiSingle :: AppList a -> AppList a -> AppList a
sacarSegundoSiSingle apL1 (Single e) = apL1
sacarSegundoSiSingle apL1 apL2 = Append apL1 apL2

reverseAL :: AppList a -> AppList a
reverseAL (Single e) = Single e
reverseAL (Append apL1 apL2) = Append reverseAL apL2 reverseAL apL1

elemAL :: Eq a => a -> AppList a -> Bool
elemAL el (Single e) = el == e
elemAL el (Append apL1 apL2) = elemAL el apL1 || elemAL el apL2 

appendAL :: AppList a -> AppList a -> AppList a
appendAL apL1 apL2 = Append apL1 apL2

appListToList :: AppList a -> [a]
appListToList (Single e) = [e]
appListToList (Append apL1 apL2) appListToList apL1 ++ appListToList apL2 



b.
    i. 
    Prop.: ¿para todo xs :: AppList a. para todo ys :: AppList a.
                lenAL (appendAL xs ys) = lenAL xs + lenAL ys?
    Dem.: Por ppio. de induccion en la estructura de xs, sean xs' e ys' :: AppListA cualquiera,
    es equivalente demostrar que:
        ¿para todo xs' e ys'. lenAL (appendAL xs' ys') = lenAL xs' + lenAL ys'?

    Caso base: xs = Single e
        ¿lenAL (appendAL (Single e) ys) = lenAL (Single e) + lenAL ys?
    
    Caso inductivo: xs = Append al1 al2
        HI.1) ¡lenAL (appendAL al1 ys) = lenAL al1 + lenAL ys!
        HI.2) ¡lenAL (appendAL al2 ys) = lenAL al2 + lenAL ys!
        HI) ¿lenAL (appendAL (Append al1 al2) ys) = lenAL (Append al1 al2) + lenAL ys?

    Dem. caso base:
        lenAL (appendAL (Single e) ys)
        = def. appendAL
        lenAL (Append (Single e) ys)
        = def. lenAL
        lenAl (Single e) + lenAl ys
        
        Se llega al lado derecho.

    
    Dem. caso inductivo:
        LI:
        lenAL (appendAL (Append al1 al2) ys)
        = def. appendAL
        lenAL (Append (Append al1 al2) ys)
        = def. lenAL
        lenAL (Append al1 al2) + lenAL ys

        LD:
        lenAL (Append al1 al2) + lenAL ys
        

    Por análisis de casos bastaba. No hacía falta la induccióNo


    b.ii

    Prop.: ¿para todo xs :: AppList a
                reverseAL . reverseAL = id?
    Dem.: extensionalidad + induccion
    es equivalente demostrar que:
        ¿para todo xs' reverseAL . reverseAL xs' = id xs'?

    Caso base: xs' = Single e
        ¿reverseAL . reverseAL (Single e) = id (Single e)?
    
    Caso inductivo: xs = Append al1 al2
        HI.1) ¡reverseAL . reverseAL al1 = id al1!
        HI.2) ¡reverseAL . reverseAL al2 = id al2!
        HI) ¿reverseAL . reverseAL (Append al1 al2) = id (Append al1 al2)?

    Dem. caso base:
        LI:
        reverseAL . reverseAL (Single e)
        = def. op. .
        reverseAL (reverseAL (Single e))
        = def. reverseAL
        reverseAL (Single e)
        = def. reverseAL
        Single e

        LD:
        id (Single e)
        = def. id
        Single e

        Se llega al mismo resultado. Vale para este caso

    Dem. caso inductivo:
        LI: 
        reverseAL . reverseAL (Append al1 al2)
        = def. op. .
        reverseAL (reverseAL (Append al1 al2))
        = def. reverseAL
        reverseAL (Append (reverseAL al2) (reverseAL al1))
        = def. reverseAL
        Append reverseAL . reverseAL al1 reverseAL . reverseAL al2
        = HI.1 y HI.2
        Append id al1 id al2
        = def. id
        Append al1 al2

        LD:
        id (Append al1 al2)
        = def. id
        Append al1 al2


    Prop.: ¿reverseAL . flip consAL . reverseAL e xs = snocAL e xs?
    Para todo x :: a
    ¿reverseAL . flip consAL . reverseAL x = snocAL x?
    Para todo x :: a. Para todo xs :: AppList a.
        ¿reverseAL . flip consAL . reverseAL e xs = snocAL e xs?
    Por definicion op. .
        reverseAL . flip consAL . reverseAL e xs = reverseAL (flip consAL (reverseAL xs) e)

    Dem. por ppio. induccion

    Caso base: xs = Single j
        ¿reverseAL (flip consAL (reverseAL (Single j)) e) = snocAL e (Single j)?
    
    Caso inductivo: xs = Append al1 al2
        HI.1) ¡reverseAL (flip consAL (reverseAL al1) e) = snocAL e al1!
        HI.2) ¡reverseAL (flip consAL (reverseAL al2) e) = snocAL e al2!
        TI) ¿reverseAL (flip consAL (reverseAL (Append al1 al2)) e) = snocAL e (Append al1 al2)?

    Dem.
        LI:
        reverseAL (flip consAL (reverseAL xs) e)
        = def. flip
        reverseAL (consAL e (reverseAL))
        = def. consAL
        reverseAL (Append (Single e) (reverseAL xs))
        = def. reverseAL
        Append (reverseAL (reverseAL xs)) (reverseAL (Single e))
        = Lema reverseAL . reverseAL = id
        Append (id xs) (reverseAL (Single e))
        = def. reverseAL e id
        Append xs (Single e)
        
        LD:
        snocAL e xs
        = def. snocAL
        Append xs (Single e)



