{-# OPTIONS -Wall -Werror #-}

import qualified Data.Foldable
import qualified Tree

main :: IO ()
main = let
  tree = foldr Tree.treeInsert Tree.EmptyTree $ ([8, 6, 4, 1, 7, 3, 5] :: [Int])
  treeSum  = Data.Foldable.foldr (+) 0 tree
  treeMul  = Data.Foldable.foldr (*) 1 tree
  treeList = Data.Foldable.foldr (:) [] tree
 in do
  putStrLn $ "treeSum = " ++ show treeSum
  putStrLn $ "treeMul = " ++ show treeMul
  putStrLn $ "treeList = " ++ show treeList

