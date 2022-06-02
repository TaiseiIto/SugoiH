{-# OPTIONS -Wall -Werror #-}

data Tree a =
 Empty |
 Node a (Tree a) (Tree a)
 deriving Show

reverseNumbers :: Int -> [Int]
reverseNumbers n
 | n <= 0    = []
 | otherwise = let m = n - 1 in (m :) . reverseNumbers $ m

numbers :: Int -> [Int]
numbers = reverse . reverseNumbers

rowInTree :: Int -> Int
rowInTree = (floor :: Double -> Int) . logBase 2 . fromIntegral . (+ 1)

columnInTree :: Int -> Int
columnInTree n = let row = rowInTree n in n - 2 ^ row + 1

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

numberElement :: [a] -> [(Int, a)]
numberElement xs = zip (numbers . length $ xs) xs

leftList :: [a] -> [a]
leftList = map snd . filter (isLeftInTree . fst) . numberElement

rightList :: [a] -> [a]
rightList = map snd . filter (isRightInTree . fst) . numberElement

list2Tree :: [a] -> Tree a
list2Tree [] = Empty
list2Tree (x : xs) = Node x (list2Tree . leftList $ x : xs) (list2Tree . rightList $ x : xs)

freeTree :: Tree Char
freeTree = list2Tree "POLLYWANTSACRAC"

data Direction  = L | R deriving Show
type Directions = [Direction]

changeElement :: Tree a -> Directions -> a -> Tree a
changeElement Empty _ _               = Empty
changeElement (Node x l r) (L : ds) y = Node x (changeElement l ds y) r
changeElement (Node x l r) (R : ds) y = Node x l (changeElement r ds y)
changeElement (Node _ l r) [] y       = Node y l r

newTree :: Tree Char
newTree = changeElement freeTree [R, L] 'P'

main :: IO ()
main = putStrLn . show $ newTree

