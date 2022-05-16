{-# OPTIONS -Wall -Werror #-}

module Shapes
(
 Point(..),
 Shape(..),
 area,
 baseCircle,
 baseRect,
 nudge,
) where

data Point = Point Float Float deriving (Show)

data Shape =
 Circle Point Float |
 Rectangle Point Point
 deriving (Show)

area :: Shape -> Float
area (Circle _ r) = pi * r ** 2
area (Rectangle (Point x1 y1) (Point x2 y2)) = (abs $ x1 - x2) * (abs $ y1 - y2)

baseCircle :: Float -> Shape
baseCircle = Circle $ Point 0 0

baseRect :: Float -> Float -> Shape
baseRect width = Rectangle (Point 0 0) . Point width

nudge :: Shape -> Float -> Float -> Shape
nudge (Circle (Point x y) r) a b = Circle (Point (x + a) (y + b)) r
nudge (Rectangle (Point x1 y1) (Point x2 y2)) a b = Rectangle (Point (x1 + a) (y1 + b)) $ Point (x2 + a) (y2 + b)

