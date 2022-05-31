{-# OPTIONS -Wall -Werror #-}

import Data.Ratio

newtype Prob a = Prob {getProb :: [(a, Rational)]} deriving Show

instance Functor Prob where
 fmap f = Prob . map (\(x, p) -> (f x, p)) . getProb

flatten :: Prob (Prob a) -> Prob a
flatten = Prob . concat . map (\(Prob ps, p) -> map (\(x, q) -> (x, p * q)) ps) . getProb

instance Applicative Prob where
 pure x = Prob [(x, 1 % 1)]
 f <*> x = Prob [(g y, p * q) | (g, p) <- getProb f, (y, q) <- getProb x]

instance Monad Prob where
 return x = Prob [(x, 1 % 1)]
 m >>= f = flatten . fmap f $ m

main :: IO ()
main = putStrLn . (show :: Prob Int -> String) . fmap negate . Prob $ [(3, 1 % 2), (4, 1 % 5), (9, 1 % 4)]

