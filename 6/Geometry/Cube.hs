{-# OPTIONS -Wall -Werror #-}

module Geometry.Cube
(
 area,
 volume
) where

import qualified Geometry.Cuboid

area :: Num a => a -> a
area side = Geometry.Cuboid.area side side side

volume :: Num a => a -> a
volume side = Geometry.Cuboid.volume side side side

