{-# LANGUAGE GADTs, StandaloneDeriving #-}
{-# OPTIONS -Wall -Werror #-}

import Data.Ratio

newtype Prob a = Prob {getProb :: [(a, Rational)]} deriving Show

delete :: Eq a => a -> Prob a -> Prob a
delete _ (Prob [])            = Prob []
delete x (Prob ((y, p) : ys)) = if x == y
 then delete x . Prob $ ys
 else Prob . ((y, p) :) . getProb . delete x . Prob $ ys

find :: Eq a => a -> Prob a -> Maybe (a, Rational)
find _ (Prob [])            = Nothing
find x (Prob ((y, p) : ys)) = if x == y
 then Just (y, p)
 else find x . Prob $ ys

unite :: Eq a => Prob a -> Prob a
unite (Prob [])            = Prob []
unite (Prob ((x, p) : xs)) = Prob $ let unitedxs = unite (Prob xs) in case find x unitedxs of
 Just (_, q) -> ((x, p + q) :) . getProb . delete x $ unitedxs
 Nothing     -> ((x, p) :) . getProb $ unitedxs

instance Functor Prob where
 fmap f x = Prob [(f y, p) | (y, p) <- getProb x]

flatten :: Prob (Prob a) -> Prob a
flatten = Prob . concat . map (\(Prob ps, p) -> map (\(x, q) -> (x, p * q)) ps) . getProb

instance Applicative Prob where
 pure x  = Prob [(x, 1 % 1)]
 f <*> x = Prob [(g y, p * q) | (g, p) <- getProb f, (y, q) <- getProb x]

instance Monad Prob where
 return x = Prob [(x, 1 % 1)]
 m >>= f  = flatten . fmap f $ m

data Coin = Heads | Tails deriving (Show, Eq)

coin :: Prob Coin
coin = Prob [(Heads, 1 % 2), (Tails, 1 % 2)]

loadedCoin :: Prob Coin
loadedCoin = Prob [(Heads, 1 % 10), (Tails, 9 % 10)]

flipThree :: Prob Bool
flipThree = unite $ do
 a <- coin
 b <- coin
 c <- loadedCoin
 return . all (== Tails) $ [a, b, c]

main :: IO ()
main = putStrLn . (show :: Prob Bool -> String) $ flipThree

