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

numberString :: String -> [(Int, Char)]
numberString string = zip (numbers . length $ string) string

leftString :: String -> String
leftString = map snd . filter (isLeftInTree . fst) . numberString

rightString :: String -> String
rightString = map snd . filter (isRightInTree . fst) . numberString

string2Tree :: String -> Tree Char
string2Tree [] = Empty
string2Tree (c : cs) = Node c (string2Tree . leftString $ c : cs) (string2Tree . rightString $ c : cs)

freeTree :: Tree Char
freeTree = string2Tree "POLLYWANTSACRAC"

data Direction  = L | R deriving Show
type Directions = [Direction]

changeChar :: Tree Char -> Directions -> Char -> Tree Char
changeChar Empty _ _               = Empty
changeChar (Node x l r) (L : ds) c = Node x (changeChar l ds c) r
changeChar (Node x l r) (R : ds) c = Node x l (changeChar r ds c)
changeChar (Node _ l r) [] c       = Node c l r

newTree :: Tree Char
newTree = changeChar freeTree [R, L] 'P'

main :: IO ()
main = putStrLn . show $ newTree

