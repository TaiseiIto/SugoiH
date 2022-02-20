{-# OPTIONS -Wall -Werror #-}

data List a = Empty | Cons a (List a)
 deriving
 (
  Show,
  Read,
  Eq,
  Ord
 )

