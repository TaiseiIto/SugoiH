{-# OPTIONS -Wall -Werror #-}

import qualified System.IO

main :: IO ()
main = System.IO.withFile "baabaa.txt" System.IO.ReadMode $ \file -> do
 contents <- System.IO.hGetContents file
 putStr contents
 return ()

