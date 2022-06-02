{-# OPTIONS -Wall -Werror #-}

-- data Tree a =
--  Empty |
--  Node a (Tree a) (Tree a)
--  deriving Show

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

numberString :: String -> [(Int, Char)]
numberString string = zip (numbers . length $ string) string

-- leftString :: String -> String
-- rightString :: String -> String

-- completeBinaryTree :: String -> Tree Char
-- completeBinaryTree [] = Empty
-- completeBinaryTree (c : cs) = Node c (completeBinaryTree . leftString $ c : cs) (completeBinaryTree . rightString $ c : cs)

main :: IO ()
main = putStrLn . show . map (isLeftInTree . fst) . numberString $ "POLLYWANTSACRAC"

