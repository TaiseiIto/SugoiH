{-# OPTIONS -Wall -Werror #-}

import Data.Ratio

newtype Prob a = Prob
 {
  getProb :: [(a, Rational)]
 } deriving Show

main :: IO ()
main = putStrLn . (show :: Prob Int -> String) . Prob $ [(3, 1 % 2), (4, 1 % 5), (9, 1 % 4)]

