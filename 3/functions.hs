{-# OPTIONS -Wall -Werror #-}

lucky :: Int -> String
lucky 7 = "LUCKY NUMBER SEVEN!"
lucky _ = "Soryy, you're out of luck, pal!"

sayMe :: Int -> String
sayMe 1 = "One!"
sayMe 2 = "Two!"
sayMe 3 = "Three!"
sayMe 4 = "Four!"
sayMe 5 = "Five!"
sayMe _ = "Not between 1 and 5"

factorial :: Int -> Int
factorial 0 = 1
factorial n = n * factorial (n - 1)

charName :: Char -> String
charName 'a' = "Albert"
charName 'b' = "Broseph"
charName 'c' = "Cecil"
charName _   = ""

addVectors :: (Double, Double) -> (Double, Double) -> (Double, Double)
addVectors (x1, y1) (x2, y2) = (x1 + x2, y1 + y2)

first :: (a, b, c) -> a
first (x, _, _) = x

second :: (a, b, c) -> b
second (_, y, _) = y

third :: (a, b, c) -> c
third (_, _, z) = z

head' :: [a] -> a
head' [] = error "Can't call head on an empty list, dummy!"
head' (x:_) = x

head'' :: [a] -> a
head'' xs =
 case xs of
  []    -> error "No head for empty lists!"
  (x:_) -> x

tell :: (Show a) => [a] -> String
tell []       = "The list is empty"
tell (x:[])   = "The list has one element: " ++ show x
tell (x:y:[]) = "The list has two elements: " ++ show x ++ " and " ++ show y
tell (x:y:_)  = "The list is long. The first two elements are: " ++ show x ++ " and " ++ show y

firstLetter :: String -> String
firstLetter "" = "Empty string, whoops!"
firstLetter xs@(x:_) = "The first letter of " ++ xs ++ " is " ++ [x]

bmiTell :: Double -> Double -> String
bmiTell weight height
 | bmi <= skinny = "You're underweight, you emo, you!"
 | bmi <= normal = "You're supposedly normail. Pffft, I bet you're ugly!"
 | bmi <= fat    = "You're fat! Lose some weight, fatty!"
 | otherwise     = "You're a whale, congratulations!"
 where
  bmi    = weight / height ** 2
  (skinny, normal, fat) = (18.5, 25.0, 30.0)

max' :: (Ord a) => a -> a -> a
max' a b
 | a <= b    = b
 | otherwise = a

myCompare :: (Ord a) => a -> a -> Ordering
a `myCompare` b
 | a == b    = EQ
 | a <  b    = LT
 | otherwise = GT

badGreeting :: String
badGreeting = "Oh! Pfft. It's you."

niceGreeting :: String
niceGreeting = "Hello! So very nice to see you,"

greet :: String -> String
greet name@"Juan"     = niceGreeting ++ " " ++ name ++ "!"
greet name@"Fernando" = niceGreeting ++ " " ++ name ++ "!"
greet name            = badGreeting ++ " " ++ name

initials :: String -> String -> String
initials "" _               = "No name"
initials _ ""               = "No name"
initials firstname lastname = [f] ++ ". " ++ [l] ++ "."
 where
  f = head firstname
  l = head lastname

calcBmis :: [(Double, Double)] -> [Double]
calcBmis xs = [bmi w h | (w, h) <- xs]
 where
  bmi weight height = weight / height ** 2

calcBmis' :: [(Double, Double)] -> [Double]
calcBmis' xs = [bmi | (w, h) <- xs, let bmi = w / h ** 2]

calcBmis'' :: [(Double, Double)] -> [Double]
calcBmis'' xs = [bmi | (w, h) <- xs, let bmi = w / h ** 2, bmi > 25.0]

cylinder :: Double -> Double -> Double
cylinder r h =
 let
  sideArea = 2 * pi * r * h
  topArea  = pi * r ** 2
 in
  sideArea + 2 * topArea

describeList0 :: [a] -> String
describeList0 []  = "The list is empty."
describeList0 [_] = "The list is a singleton list."
describeList0 _   = "The list is a lonber list."

describeList1 :: [a] -> String
describeList1 ls = "The list is " ++
 case ls of
  []  -> "empty."
  [_] -> "a singleton list."
  _   -> "a longer list."

describeList2 :: [a] -> String
describeList2 ls = "The list is " ++ what ls
 where
  what []  = "empty."
  what [_] = "a singleton list."
  what _   = "a longer list."

describeList3 :: [a] -> String
describeList3 ls = "The list is " ++
 let
  what []  = "empty."
  what [_] = "a singleton list."
  what _   = "a longer list."
 in what ls
  
