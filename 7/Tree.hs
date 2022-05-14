{-# OPTIONS -Wall -Werror #-}

module Tree where

data Tree a
 where
  EmptyTree :: Tree a
  Node :: a -> Tree a -> Tree a -> Tree a

deriving instance Show a => Show (Tree a)

treeInsert :: Ord a => a -> Tree a -> Tree a
treeInsert new_value EmptyTree = Node new_value EmptyTree EmptyTree
treeInsert new_value (Node root_value left_subtree right_subtree)
 | new_value == root_value = Node root_value left_subtree right_subtree
 | new_value <  root_value = Node root_value (treeInsert new_value left_subtree) right_subtree
 | otherwise               = Node root_value left_subtree (treeInsert new_value right_subtree)

treeElem :: Ord a => a -> Tree a -> Bool
treeElem _ EmptyTree = False
treeElem value (Node root_value left_subtree right_subtree)
 | value == root_value = True
 | value <  root_value = treeElem value left_subtree
 | otherwise           = treeElem value right_subtree

numsTree :: Ord a => [a] -> Tree a
numsTree = foldr treeInsert EmptyTree

instance Functor Tree where
 fmap _ EmptyTree = EmptyTree
 fmap f (Node x left right) = Node (f x) (fmap f left) (fmap f right)

