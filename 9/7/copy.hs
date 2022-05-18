{-# OPTIONS -Wall -Werror #-}

import qualified System.Environment

main :: IO ()
main = do
 args <- System.Environment.getArgs
 case args of
  [src, dst] -> putStrLn $ "src = " ++ show src ++ ", dst = " ++ show dst
  _          -> printUsage
 return ()

printUsage :: IO ()
printUsage = do
 progName <- System.Environment.getProgName
 putStrLn $ "Usage : ./" ++ progName ++ " <source> <destination>"

