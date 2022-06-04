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

elemAt :: Directions -> Tree a -> Maybe a
elemAt (L : ds) (Node _ l _) = elemAt ds $ l
elemAt (R : ds) (Node _ _ r) = elemAt ds $ r
elemAt []       (Node x _ _) = Just x
elemAt _        Empty        = Nothing

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

zipTree :: Tree a -> Zipper a
zipTree tree = (tree, [])

goLeft :: Zipper a -> Maybe (Zipper a)
goLeft (Node x l r, bs) = Just (l, LeftCrumb x r : bs)
goLeft (Empty,      _)  = Nothing

goRight :: Zipper a -> Maybe (Zipper a)
goRight (Node x l r, bs) = Just (r, RightCrumb x l : bs)
goRight (Empty,      _)  = Nothing

goUp :: Zipper a -> Maybe (Zipper a)
goUp (t, LeftCrumb  x r : bs) = Just (Node x t r, bs)
goUp (t, RightCrumb x l : bs) = Just (Node x l t, bs)
goUp (_, [])                  = Nothing

topMost :: Zipper a -> Maybe (Zipper a)
topMost (t, []) = Just (t, [])
topMost z       = do
 up <- goUp z
 topMost up

modify :: (a -> a) -> Zipper a -> Zipper a
modify f (Node x l r, bs) = (Node (f x) l r, bs)
modify _ (Empty,      bs) = (Empty,          bs)

attach :: Tree a -> Zipper a -> Zipper a
attach t (_, bs) = (t, bs)

freeTree :: Tree Char
freeTree = list2tree "POLLYWANTSACRAC"

newTree :: Tree Char
newTree = changeElement [R, L] 'P' freeTree

unJust :: Maybe String -> String
unJust (Just s) = s
unJust Nothing  = ""

main :: IO ()
main = do
 putStrLn . tree2list $ newTree
 putStrLn . show . elemAt [R, L] $ freeTree
 putStrLn . unJust $ do
  pos0 <- goRight . zipTree $ freeTree
  pos1 <- goLeft pos0
  return . tree2list . fst $ pos1
 putStrLn . unJust $ do
  pos0 <- goRight . zipTree $ freeTree
  pos1 <- goLeft pos0
  pos2 <- topMost . modify (\_ -> 'P') $ pos1
  return . tree2list . fst $ pos2
 putStrLn . unJust $ do
  pos0 <- goLeft . zipTree $ freeTree
  pos1 <- goLeft pos0
  pos2 <- goLeft pos1
  pos3 <- goLeft pos2
  pos4 <- topMost . attach (Node 'Z' Empty Empty) $ pos3
  return . tree2list . fst $ pos4

