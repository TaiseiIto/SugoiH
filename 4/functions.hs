{-# OPTIONS -Wall -Werror #-}

max' :: (Ord a) => a -> a -> a
a `max'` b
 | a > b     = a
 | otherwise = b

maximum' :: (Ord a) => [a] -> a
maximum' [] = error "maximum of empty list!"
maximum' [x] = x
maximum' (x:xs) = x `max'` (maximum' xs)

replicate' :: Int -> a -> [a]
replicate' n x
 | n <= 0    = []
 | otherwise = x : replicate' (n - 1) x

take' :: Int -> [a] -> [a]
take' _ [] = []
take' n (x:xs)
 | n <= 0    = []
 | otherwise = x : take' (n - 1) xs

reverse' :: [a] -> [a]
reverse' []     = []
reverse' (x:xs) = reverse' xs ++ [x]

repeat' :: a  -> [a]
repeat' x = x : repeat' x

zip' :: [a] -> [b] -> [(a, b)]
zip' [] _          = []
zip' _ []          = []
zip' (x:xs) (y:ys) = (x, y) : zip' xs ys

elem' :: (Eq a) => a -> [a] -> Bool
elem' _ [] = False
elem' a (x:xs)
 | a == x    = True
 | otherwise = elem' a xs

quickSort :: (Ord a) => [a] -> [a]
quickSort []     = []
quickSort (x:xs) = quickSort [l | l <- xs, l < x] ++ x : quickSort [g | g <- xs, x <= g]

