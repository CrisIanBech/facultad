map :: (a -> b) -> [a] -> [b]
map f []     = []
map f (x:xs) = f x : (map f xs)

filter :: (a -> Bool) -> [a] -> [a]
filter f []     = []
filter f (x:xs) = if(f x) then x : (filter f xs) else filter f xs

foldr :: (a -> b -> b) -> b -> [a] -> b
foldr f z []     = z
foldr f z (x:xs) = f x (foldr f z xs)  

recr :: b -> (a -> [a] -> b -> b) -> [a] -> b
recr z f []     = z
recr z f (x:xs) = f x xs (recr z f xs)

foldr1 :: (a -> a -> a) -> [a] -> a
foldr1 f []     = []
foldr1 f (x:xs) = f x (foldr1 f xs)

zipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith f [] _          = []
zipWith f _  []         = []
zipWith f (x:xs) (y:ys) = (f x y) : (zipWith f xs ys)    

scanr :: (a -> b -> b) -> b -> [a] -> [b]
scanr f e []     = []
scanr f e (x:xs) = f x e : (scanr f e xs)


