{-# OPTIONS -Wall -Werror #-}

import qualified Control.Monad

type KnightPos   = (Int, Int)
type KnightRoute = [KnightPos]

main :: IO ()
main = do
 putStrLn . show $ (6, 2) `canReachIn3` (6, 1)
 putStrLn . show $ (6, 2) `canReachIn3` (7, 3)

canReachIn3 :: KnightPos -> KnightPos -> [KnightRoute]
canReachIn3 start end = filter ((== end) . head) . step3 $ start

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
 return (newPos : (p : ps))

step3 :: KnightPos -> [KnightRoute]
step3 pos = do
 first  <- step . return $ pos
 second <- step first
 third  <- step second
 return third

