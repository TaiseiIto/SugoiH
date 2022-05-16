{-# OPTIONS -Wall -Werror #-}

mult3 :: (Num a) => a -> a -> a -> a
mult3 x y z = x * y * z

compareWith100 :: Int -> Ordering
compareWith100 = compare 100

divideBy10 :: (Floating a) => a -> a
divideBy10 = (/10)

isUpperAlphanum :: Char -> Bool
isUpperAlphanum = (`elem` ['A'..'Z'])

applyTwice :: (a -> a) -> a -> a
applyTwice f x = f (f x)

zip' :: [a] -> [b] -> [(a, b)]
zip' [] _ = []
zip' _ [] = []
zip' (x:xs) (y:ys) = (x, y) : zip' xs ys

zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith' _ [] _          = []
zipWith' _ _ []          = []
zipWith' f (x:xs) (y:ys) = f x y : zipWith' f xs ys

flip' :: (a -> b -> c) -> (b -> a -> c)
flip' f y x = f x y

map0 :: (a -> b) -> [a] -> [b]
map0 _ [] = []
map0 f (x:xs) = f x : map0 f xs

map1 :: (a -> b) -> [a] -> [b]
map1 f = foldr (\x xs -> f x : xs) []

map2 :: (a -> b) -> [a] -> [b]
map2 f = foldl (\xs x -> xs ++ [f x]) []

filter0 :: (a -> Bool) -> [a] -> [a]
filter0 _ [] = []
filter0 f (x:xs)
 | f x       = x : filter0 f xs
 | otherwise = filter0 f xs

filter1 :: (a -> Bool) -> [a] -> [a]
filter1 f = foldr (\x xs -> if f x then x:xs else xs) []

collatz :: Int -> [Int]
collatz n
 | n <= 0    = []
 | n == 1    = [1]
 | even n    = n : collatz (n `div` 2)
 | otherwise = n : collatz (3 * n + 1)

numLongChains :: Int
numLongChains = let isLong xs = length xs > 15 in length (filter isLong (map collatz [1..100]))

numLongChains' :: Int
numLongChains' = length (filter (\xs -> length xs > 15) (map collatz [1..100]))

sum' :: (Foldable f, Num n) => f n -> n
sum' = foldl (+) 0

elem' :: (Eq a) => a -> [a] -> Bool
elem' x = foldr (\a b -> if a == x then True else b) False

maximum' :: (Ord a) => [a] -> a
maximum' = foldl1 max

reverse' :: [a] -> [a]
reverse' = foldl (flip (:)) []

product' :: (Num a) => [a] -> a
product' = foldl (*) 1

last' :: [a] -> a
last' = foldl1 (\_ b -> b)

and' :: [Bool] -> Bool
and' = foldr (&&) True

sqrtSums :: Int
sqrtSums = length (takeWhile (< (1000 :: Double)) (scanl1 (+) (map sqrt [1..]))) + 1

oddSquareSum :: Integer
oddSquareSum = sum . takeWhile (<10000) . filter odd $ map (^(2::Integer)) [1..]

