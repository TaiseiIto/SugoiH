{-# OPTIONS -Wall -Werror #-}

import qualified System.IO

main :: IO ()
main = do
 System.IO.hSetBuffering System.IO.stdout System.IO.NoBuffering
 putStr "YourName : "
 name <- getLine
 putStrLn $ "Hey " ++ name ++ ", you rock!"

