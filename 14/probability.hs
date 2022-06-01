{-# OPTIONS -Wall -Werror #-}

import Data.Ratio

newtype Prob a = Prob {getProb :: [(a, Rational)]} deriving Show

instance Functor Prob where
 fmap f x = Prob [(f y, p) | (y, p) <- getProb x]

flatten :: Prob (Prob a) -> Prob a
flatten = Prob . concat . map (\(Prob ps, p) -> map (\(x, q) -> (x, p * q)) ps) . getProb

instance Applicative Prob where
 pure x = Prob [(x, 1 % 1)]
 f <*> x = Prob [(g y, p * q) | (g, p) <- getProb f, (y, q) <- getProb x]

instance Monad Prob where
 return x = Prob [(x, 1 % 1)]
 m >>= f = flatten . fmap f $ m

data Coin = Heads | Tails deriving (Show, Eq)

coin :: Prob Coin
coin = Prob [(Heads, 1 % 2), (Tails, 1 % 2)]

loadedCoin :: Prob Coin
loadedCoin = Prob [(Heads, 1 % 10), (Tails, 9 % 10)]

flipThree :: Prob Bool
flipThree = do
 a <- coin
 b <- coin
 c <- loadedCoin
 return . all (== Tails) $ [a, b, c]

main :: IO ()
main = putStrLn . (show :: Prob Bool -> String) $ flipThree

