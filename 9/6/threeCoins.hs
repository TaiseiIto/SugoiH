{-# OPTIONS -Wall -Werror #-}

import qualified System.Random

coins :: Int -> ([Bool], System.Random.StdGen)
coins n
 | n <= 0    = ([], System.Random.mkStdGen 100)
 | otherwise = let
    (prevCoins, gen) = coins $ n - 1
    (newCoin, newGen) = System.Random.random gen :: (Bool, System.Random.StdGen)
    in (newCoin : prevCoins, newGen)

main :: IO ()
main = let
 (threeCoins, _) = coins 3
 in putStrLn . show $ threeCoins
 
