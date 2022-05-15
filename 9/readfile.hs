{-# OPTIONS -Wall -Werror #-}

import qualified System.IO

main :: IO ()
main = do
 contents <- System.IO.readFile "baabaa.txt"
 putStr contents

