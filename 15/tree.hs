{-# OPTIONS -Wall -Werror #-}

-- data Tree a =
--  Empty |
--  Node a (Tree a) (Tree a)
--  deriving Show

reverseNumbers :: Int -> [Int]
reverseNumbers n
 | n < 0     = []
 | otherwise = (n :) . reverseNumbers $ n - 1

-- leftString :: String -> String
-- rightString :: String -> String

-- completeBinaryTree :: String -> Tree Char
-- completeBinaryTree [] = Empty
-- completeBinaryTree (c : cs) = Node c (completeBinaryTree . leftString $ c : cs) (completeBinaryTree . rightString $ c : cs)

main :: IO ()
main = putStrLn . show . reverseNumbers $ 10

