{-# OPTIONS -Wall -Werror #-}

infixr 5 :-:
data List a = Empty | a :-: (List a)
 deriving
 (
  Show,
  Read,
  Eq,
  Ord
 )

infixr 5 ^++
(^++) :: List a -> List a -> List a
Empty ^++ b = b
(head_a :-: tail_a) ^++ b = head_a :-: (tail_a ^++ b)

