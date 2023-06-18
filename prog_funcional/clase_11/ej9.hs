foldr' :: (a -> b -> b) -> b -> [a] -> b  
foldr' f z []        = z
foldr' f z (x:xs)    = f x (foldr f z xs)

sum :: [Int] -> Int
sum = foldr' (+) 0

length :: [a] -> Int
length = foldr' (\e l -> 1 + l) 0

-- map' :: [a] -> (a -> b) -> [b]
-- map' []     = \f -> []
-- map' (x:xs) = \f -> f x : (map' xs f) 

map' :: (a -> b) -> [a] -> [b]
map' = flip (foldr' (\x xs f -> f x : xs f) (const []))

filter :: (a -> Bool) -> [a] -> [a]
filter = flip (foldr' (\x xs f -> if f x then x : xs f else xs f) (const []))

find :: (a -> Bool) -> [a] -> Maybe a
find = flip (foldr' (\x h f -> if f x then Just x else h f) (const Nothing))

any :: (a -> Bool) -> [a] -> Bool
any = flip (foldr' g (const False))
        where g x h f = f x || (h f)

all :: (a -> Bool) -> [a] -> Bool
all = flip (foldr' g (const True))
            where g x h f = f x && h f

countBy :: (a -> Bool) -> [a] -> Int
countBy = flip (foldr' g (const 0))
            where g x h f = (if(f x) then 1 else 0) + h f 

partition :: (a -> Bool) -> [a] -> ([a], [a])
partition = flip (foldr' g (const ([], [])))
                where g x h f = let (yes, no) = h f
                                    in if(f x) then (x : yes, no) else (yes, x : no) 

zipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith = flip (foldr' g (const (const [])))
            where g x h f ys = f x (head ys) : h f (tail ys)

scanr :: (a -> b -> b) -> b -> [a] -> [b]
scanr = thirdToFirst (foldr' g (const . const []))
            where g x h e f = f x e : h e f 

thirdToFirst :: (c -> b -> a -> d) -> a -> b -> c -> d
thirdToFirst f x y z = f z y x

takeWhile :: (a -> Bool) -> [a] -> [a]
takeWhile = flip (foldr' g (const []))
                where g x h f = if(f x) then x : h f else h f

take :: Int -> [a] -> [a]
take = flip (foldr' g (const []))
            where g x h n = if n == 0 then [] else x : h (n - 1)

drop :: Int -> [a] -> [a]
drop = flip (foldr' g (const []))
        where g e h n = if(n > 0) then h (n - 1) else e : h (n - 1)
              

(!!) :: Int -> [a] -> a
(!!) = flip (foldr' g (error "no se encuentra en la lista"))
        where g x h n = if(n == 0) then x else h (n - 1)


ej.10

a. filter id :: [a] -> [b]

b. map (\x y z -> (x, y, z)) :: No tiene.

c. map (+) :: No tiene

d. filter fst :: [(Bool, Bool)] -> [(Bool, Bool)]

e. filter (flip const (+)) :: No tiene

f. map const :: No tiene

g. map twice ::  ((a -> a) -> a -> a) -> [(a -> a)] -> [a -> a]

h. foldr twice :: a -> [(a -> a)] -> a

i. zipWith fst :: (a -> b -> c) -> [a] -> [b] -> [c] :: No tiene

j. foldr (\x r z -> (x, z) : r z) (const []) :: [a] -> b -> [(a, b)]
