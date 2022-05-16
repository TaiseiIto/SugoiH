{-# OPTIONS -Wall -Werror #-}

import qualified System.IO

main :: IO ()
main = do
 file <- System.IO.openFile "baabaa.txt" System.IO.ReadMode
 contents <- System.IO.hGetContents file
 putStr contents
 System.IO.hClose file
 return ()

