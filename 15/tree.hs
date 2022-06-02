{-# OPTIONS -Wall -Werror #-}

data Tree a =
 Empty |
 Node a (Tree a) (Tree a)
 deriving Show

reverseNumbers :: Int -> [Int]
reverseNumbers n
 | n <= 0    = []
 | otherwise =
  let
   m = n - 1
  in
   (m :) . reverseNumbers $ m

numbers :: Int -> [Int]
numbers = reverse . reverseNumbers

rowInTree :: Int -> Int
rowInTree = (floor :: Double -> Int) . logBase 2 . fromIntegral . (+ 1)

columnInTree :: Int -> Int
columnInTree n =
 let
  row = rowInTree n
 in
  n - 2 ^ row + 1

isLeftInTree :: Int -> Bool
isLeftInTree n
 | n == 0    = False
 | otherwise =
  let
   row    = rowInTree    n
   column = columnInTree n
  in
   column < 2 ^ (row - 1)

isRightInTree :: Int -> Bool
isRightInTree n
 | n == 0    = False
 | otherwise = not . isLeftInTree $ n

numberList :: [a] -> [(Int, a)]
numberList xs = zip (numbers . length $ xs) xs

leftList :: [a] -> [a]
leftList = map snd . filter (isLeftInTree . fst) . numberList

rightList :: [a] -> [a]
rightList = map snd . filter (isRightInTree . fst) . numberList

list2tree :: [a] -> Tree a
list2tree [] = Empty
list2tree (x : xs) = Node x (list2tree . leftList $ x : xs) (list2tree . rightList $ x : xs)

numberSubTree :: Int -> Tree a -> Tree (Int, a)
numberSubTree _ Empty        = Empty
numberSubTree n (Node x l r) = Node (n, x) (numberSubTree (2 * n + 1) l) (numberSubTree (2 * (n + 1)) r)

numberTree :: Tree a -> Tree (Int, a)
numberTree = numberSubTree 0

flattenTree :: Tree a -> [a]
flattenTree Empty = []
flattenTree (Node x l r) = x : (flattenTree l ++ flattenTree r)

sortByFirst :: Ord a => [(a, b)] -> [(a, b)]
sortByFirst [] = []
sortByFirst ((i, x) : ixs) = sortByFirst [forward | forward <- ixs, fst forward < i] ++ [(i, x)] ++ sortByFirst [backward | backward <- ixs, i <= fst backward]

tree2list :: Tree a -> [a]
tree2list = map snd . sortByFirst . flattenTree . numberTree

data Direction  = L | R deriving Show
type Directions = [Direction]

changeElement :: Tree a -> Directions -> a -> Tree a
changeElement Empty _ _               = Empty
changeElement (Node x l r) (L : ds) y = Node x (changeElement l ds y) r
changeElement (Node x l r) (R : ds) y = Node x l (changeElement r ds y)
changeElement (Node _ l r) [] y       = Node y l r

freeTree :: Tree Char
freeTree = list2tree "POLLYWANTSACRAC"

newTree :: Tree Char
newTree = changeElement freeTree [R, L] 'P'

main :: IO ()
main = putStrLn . show . tree2list $ newTree

