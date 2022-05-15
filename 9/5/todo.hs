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
action ("add" : _) = do
 putStrLn $ "add"
 return ()
action ("remove" : _) = do
 putStrLn $ "remove"
 return ()
action ("view" : _) = do
 putStrLn $ "view"
 return ()
action (command : _) = do
 putStrLn $ "Invalid command : " ++ command
 return ()

