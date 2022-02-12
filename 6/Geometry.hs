{-# OPTIONS -Wall -Werror #-}

module Geometry
(
 cuboidArea,
 cuboidVolume,
 cubeArea,
 cubeVolume,
 sphereArea,
 sphereVolume
) where

cuboidArea :: Num a => a -> a -> a -> a
cuboidArea a b = (2 * a * b +) . (2 * (a + b) *)

cuboidVolume :: Num a => a -> a -> a -> a
cuboidVolume a = (*) . (a*)

cubeArea :: Num a => a -> a
cubeArea side = cuboidArea side side side

cubeVolume :: Num a => a -> a
cubeVolume side = cuboidVolume side side side

sphereArea :: Floating a => a -> a
sphereArea = (4.0 * pi *) . (**2)

sphereVolume :: Floating a => a -> a
sphereVolume = ((4.0 / 3.0) * pi *) . (**3)

