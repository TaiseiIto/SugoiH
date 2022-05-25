{-# OPTIONS -Wall -Werror #-}

import qualified Control.Monad

type KnightPos = (Int, Int)

main :: IO ()
main = do
 putStrLn . show $ (6, 2) `canReachIn3` (6, 1)
 putStrLn . show $ (6, 2) `canReachIn3` (7, 3)

canReachIn3 :: KnightPos -> KnightPos -> Bool
canReachIn3 = flip elem . in3

in3 :: KnightPos -> [KnightPos]
in3 start = do
 first  <- moveKnight start
 second <- moveKnight first
 third  <- moveKnight second
 return third

moveKnight :: KnightPos -> [KnightPos]
moveKnight (c, r) = do
 cRange   <- [1..8]
 rRange   <- [1..8]
 (c', r') <-
  [
   (c + 2, r - 1),
   (c + 2, r + 1),
   (c - 2, r - 1),
   (c - 2, r + 1),
   (c + 1, r - 2),
   (c + 1, r + 2),
   (c - 1, r - 2),
   (c - 1, r + 2)
  ]
 Control.Monad.guard $ (c', r') == (cRange, rRange)
 return (c', r')

