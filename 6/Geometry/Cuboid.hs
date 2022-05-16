{-# OPTIONS -Wall -Werror #-}

module Geometry.Cuboid
(
 area,
 volume
) where

area :: Num a => a -> a -> a -> a
area a b = (2 * a * b +) . (2 * (a + b) *)

volume :: Num a => a -> a -> a -> a
volume a = (*) . (a *)

