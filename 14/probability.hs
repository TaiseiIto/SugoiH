{-# OPTIONS -Wall -Werror #-}

import Data.Ratio

newtype Prob a = Prob {getProb :: [(a, Rational)]} deriving Show

instance Functor Prob where
 fmap f = Prob . map (\(x, p) -> (f x, p)) . getProb

main :: IO ()
main = putStrLn . (show :: Prob Int -> String) . fmap negate . Prob $ [(3, 1 % 2), (4, 1 % 5), (9, 1 % 4)]

