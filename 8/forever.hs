{-# OPTIONS -Wall -Werror #-}

import qualified Control.Monad
import qualified Data.Char
import qualified System.IO

main :: IO ()
main = do
 System.IO.hSetBuffering System.IO.stdout System.IO.NoBuffering
 Control.Monad.forever $ do
  putStr "Give me some input : "
  line <- getLine
  putStrLn $ map Data.Char.toUpper line

