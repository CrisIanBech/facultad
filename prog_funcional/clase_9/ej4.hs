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
reverseAL (Append apL1 apL2) = Append apL2 apL1

elemAL :: Eq a => a -> AppList a -> Bool
elemAL el (Single e) = el == e
elemAL el (Append apL1 apL2) = elemAL el apL1 || elemAL el apL2 

appendAL :: AppList a -> AppList a -> AppList a
appendAL apL1 apL2 = Append apL1 apL2

appListToList :: AppList a -> [a]
appListToList (Single e) = [e]
appListToList (Append apL1 apL2) appListToList apL1 ++ appListToList apL2 

