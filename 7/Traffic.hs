{-# OPTIONS -Wall -Werror #-}

module Traffic where

data TrafficLight = Red | Yellow | Green

instance Eq TrafficLight
 where
  Red    == Red    = True
  Green  == Green  = True
  Yellow == Yellow = True
  _      == _      = False

instance Show TrafficLight
 where
  show Red    = "Red Light"
  show Green  = "Green Light"
  show Yellow = "Yellow Light"

