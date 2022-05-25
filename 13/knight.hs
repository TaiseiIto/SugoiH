{-# OPTIONS -Wall -Werror #-}

import qualified Control.Monad

type KnightPos = (Int, Int)

main :: IO ()
main = putStrLn . show . moveKnight $ (6, 2)

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

