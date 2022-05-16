{-# OPTIONS -Wall -Werror #-}

import qualified Data.Char
import qualified System.IO

main :: IO ()
main = do
 contents <- System.IO.readFile "baabaa.txt"
 writeFile "baabaacaps.txt" $ map Data.Char.toUpper contents
 return ()

