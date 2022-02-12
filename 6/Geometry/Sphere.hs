{-# OPTION -Wall -Werror #-}

module Geometry.Sphere
(
 area,
 volume
) where

area :: Floating a => a -> a
area = (4.0 * pi *) . (**2)

volume :: Floating a => a -> a
volume = ((4.0 / 3.0) * pi *) . (**3)

