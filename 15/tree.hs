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
type BreadCrumbs = [Direction]

elemAt :: BreadCrumbs -> Tree a -> a
elemAt (L : ds) (Node _ l _) = elemAt ds l
elemAt (R : ds) (Node _ _ r) = elemAt ds r
elemAt []       (Node x _ _) = x
elemAt _        Empty        = error "Error @ elemAt"

changeElement :: BreadCrumbs -> a -> Tree a -> Tree a
changeElement _ _ Empty               = Empty
changeElement (L : ds) y (Node x l r) = Node x (changeElement ds y l) r
changeElement (R : ds) y (Node x l r) = Node x l (changeElement ds y r)
changeElement []       y (Node _ l r) = Node y l r

goLeft :: (Tree a, BreadCrumbs) -> (Tree a, BreadCrumbs)
goLeft (Node _ l _, bs) = (l, L:bs)
goLeft (Empty,      _)  = error "Error @ goLeft"

goRight :: (Tree a, BreadCrumbs) -> (Tree a, BreadCrumbs)
goRight (Node _ _ r, bs) = (r, R:bs)
goRight (Empty,      _)  = error "Error @ goRight"

freeTree :: Tree Char
freeTree = list2tree "POLLYWANTSACRAC"

newTree :: Tree Char
newTree = changeElement [R, L] 'P' freeTree

main :: IO ()
main = do
 putStrLn . show . tree2list $ newTree
 putStrLn . show . elemAt [R, L] $ newTree
 putStrLn . show . goLeft . goRight $ (newTree, [])

