{-# OPTIONS -Wall -Werror #-}

import System.IO

main :: IO ()
main = do
 hSetBuffering stdout NoBuffering
 putStr "YourName : "
 name <- getLine
 putStrLn $ "Hey " ++ name ++ ", you rock!"

