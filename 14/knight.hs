{-# OPTIONS -Wall -Werror #-}

import qualified Control.Monad

type KnightPos   = (Int, Int)
type KnightRoute = [KnightPos]

main :: IO ()
main = do
 putStrLn . show $ canReachIn 3 (6, 2) (6, 1)
 putStrLn . show $ canReachIn 3 (6, 2) (7, 3)

canReachIn :: Int -> KnightPos -> KnightPos -> [KnightRoute]
canReachIn time start end = map reverse . filter ((== end) . head) . steps time $ start

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

step :: KnightRoute -> [KnightRoute]
step []       = []
step (p : ps) = do
 newPos <- moveKnight p
 return . (newPos :) . (p :) $ ps

steps :: Int -> KnightPos -> [KnightRoute]
steps time start = return [start] >>= foldr (Control.Monad.<=<) return (replicate time step)

