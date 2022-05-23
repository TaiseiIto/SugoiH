{-# OPTIONS -Wall -Werror #-}

import qualified Data.Foldable
import qualified Tree

main :: IO ()
main = let
  tree = foldr Tree.treeInsert Tree.EmptyTree $ ([8, 6, 4, 1, 7, 3, 5] :: [Int])
  treeSum  = Data.Foldable.foldl (+) 0 tree
  treeMul  = Data.Foldable.foldl (*) 1 tree
 in do
  putStrLn $ "treeSum = " ++ show treeSum
  putStrLn $ "treeMul = " ++ show treeMul

