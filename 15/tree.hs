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

-- leftString :: String -> String
-- rightString :: String -> String

-- completeBinaryTree :: String -> Tree Char
-- completeBinaryTree [] = Empty
-- completeBinaryTree (c : cs) = Node c (completeBinaryTree . leftString $ c : cs) (completeBinaryTree . rightString $ c : cs)

main :: IO ()
main = putStrLn . show . numbers $ 10

