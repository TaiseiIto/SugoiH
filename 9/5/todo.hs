{-# OPTIONS -Wall -Werror #-}

import qualified System.Environment

main :: IO ()
main = do
 commandLineArguments <- System.Environment.getArgs
 action commandLineArguments
 return ()

action :: [String] -> IO ()
action [] = do
 putStrLn "No command"
 return ()
action (command : _) = do
 putStrLn $ "Invalid command : " ++ command

