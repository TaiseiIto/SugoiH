{-# OPTIONS -Wall -Werror #-}

import Tree
import Traffic

class YesNo a where
 yesno :: a -> Bool

instance YesNo Int where
 yesno 0 = False
 yesno _ = True

instance YesNo [a] where
 yesno [] = False
 yesno _  = True

instance YesNo Bool where
 yesno = id

instance YesNo (Maybe a) where
 yesno Nothing  = False
 yesno (Just _) = True

instance YesNo (Tree.Tree a) where
 yesno EmptyTree = False
 yesno _         = True

instance YesNo Traffic.TrafficLight where
 yesno Red = False
 yesno _   = True

yesnoIf :: (YesNo y) => y -> a -> a -> a
yesnoIf yesnoVal yesResult noResult
 | yesno yesnoVal = yesResult
 | otherwise      = noResult

