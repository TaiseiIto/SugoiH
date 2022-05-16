{-# OPTIONS -Wall -Werror #-}

import qualified System.Environment

main :: IO ()
main = do
 progName <- System.Environment.getProgName
 args <- System.Environment.getArgs
 putStrLn "The program name is :"
 putStrLn progName
 putStrLn "The arguments are :"
 mapM_ putStrLn args
 return ()

