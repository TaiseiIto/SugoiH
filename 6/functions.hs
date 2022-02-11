{-# OPTIONS -Wall -Werror #-}

import qualified Data.Char
import qualified Data.List
import qualified Data.Map

numUniques :: (Eq a) => [a] -> Int
numUniques = length . Data.List.nub

wordNums :: String -> [(String, Int)]
wordNums = map (\wordList -> (head wordList, length wordList)) . Data.List.group . Data.List.sort . Data.List.words

isInfixOf :: (Eq a) => [a] -> [a] -> Bool
needle `isInfixOf` haystack = any (needle `Data.List.isPrefixOf`) $ Data.List.tails haystack

encode :: Int -> String -> String
encode offset = map $ Data.Char.chr . (+ offset) . Data.Char.ord

decode :: Int -> String -> String
decode offset = encode $ negate offset

digitSum :: Int -> Int
digitSum = sum . map Data.Char.digitToInt . show

firstTo :: Int -> Maybe Int
firstTo n = Data.List.find ((n==) . digitSum) [1..]

phoneBook :: Data.Map.Map String String
phoneBook = Data.Map.fromList
 [
  ("betty","555-2938"),
  ("betty","342-2492"),
  ("bonnie","452-2928"),
  ("patsy","493-2928"),
  ("patsy","943-2929"),
  ("patsy","827-9162"),
  ("lucille","205-2928"),
  ("wendy","939-8282"),
  ("penny","853-2492")
  ("penny","555-2111")
 ]

findKey :: (Eq k) => k -> [(k, v)] -> Maybe v
findKey key = foldr (\(k,v) a -> if k == key then Just v else a) Nothing

string2digits :: String -> [Int]
string2digits = map Data.Char.digitToInt . filter Data.Char.isDigit

