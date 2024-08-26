apply f = g
    where g x = f x

suma x = x + 1

twice f = g
    where g x = f (f x)

flip f x y = (f y) x 

doble x = x + x

compose f g x = f(g x)

fst ab = let (x, y) = ab in x

snd ab = let (x, y) = ab in y