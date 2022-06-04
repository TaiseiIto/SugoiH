{-# OPTIONS -Wall -Werror #-}

infixl 9 -:
(-:) :: a -> (a -> b) -> b
x -: f = f x

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
list2tree xs = Node (head xs) (list2tree . leftList $ xs) (list2tree . rightList $ xs)

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

data Direction = L | R deriving Show

type Directions = [Direction]

elemAt :: Directions -> Tree a -> a
elemAt (L : ds) (Node _ l _) = elemAt ds l
elemAt (R : ds) (Node _ _ r) = elemAt ds r
elemAt []                    (Node x _ _) = x
elemAt _                     Empty        = error "Error @ elemAt"

changeElement :: Directions -> a -> Tree a -> Tree a
changeElement _ _ Empty               = Empty
changeElement (L : ds) y (Node x l r) = Node x (changeElement ds y l) r
changeElement (R : ds) y (Node x l r) = Node x l (changeElement ds y r)
changeElement []       y (Node _ l r) = Node y l r

data Crumb a =
 LeftCrumb  a (Tree a) |
 RightCrumb a (Tree a)
 deriving Show

type Breadcrumbs a = [Crumb a]

type Zipper a = (Tree a, Breadcrumbs a)

goLeft :: Zipper a -> Zipper a
goLeft (Node x l r, bs) = (l, LeftCrumb x r : bs)
goLeft (Empty,      _)  = error "Error @ goLeft"

goRight :: Zipper a -> Zipper a
goRight (Node x l r, bs) = (r, RightCrumb x l : bs)
goRight (Empty,      _)  = error "Error @ goRight"

goUp :: Zipper a -> Zipper a
goUp (t, LeftCrumb  x r : bs) = (Node x t r, bs)
goUp (t, RightCrumb x l : bs) = (Node x l t, bs)
goUp (_, [])                  = error "Error @ goUp"

topMost :: Zipper a -> Zipper a
topMost (t, []) = (t, [])
topMost z       = topMost . goUp $ z

modify :: (a -> a) -> Zipper a -> Zipper a
modify f (Node x l r, bs) = (Node (f x) l r, bs)
modify _ (Empty,      bs) = (Empty,          bs)

attach :: Tree a -> Zipper a -> Zipper a
attach t (_, bs) = (t, bs)

freeTree :: Tree Char
freeTree = list2tree "POLLYWANTSACRAC"

newTree :: Tree Char
newTree = changeElement [R, L] 'P' freeTree

main :: IO ()
main = do
 putStrLn . show . tree2list $ newTree
 putStrLn . show . elemAt [R, L] $ freeTree
 putStrLn . show . tree2list . fst $ (freeTree, []) -: goRight -: goLeft
 putStrLn . show . tree2list . fst $ (freeTree, []) -: goLeft -: goRight -: modify (\_ -> 'P')
 putStrLn . show . tree2list . fst $ (freeTree, []) -: goLeft -: goLeft -: goLeft -: goLeft -: attach (Node 'Z' Empty Empty) -: topMost

