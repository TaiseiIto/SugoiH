{-# OPTIONS -Wall -Werror #-}

-- Usage
-- $ ./guess_the_number <max absolute number>

import qualified System.Environment
import qualified System.Random

main :: IO ()
main = do
 args <- System.Environment.getArgs
 randGen <- System.Random.getStdGen
 case args of
  [arg] -> case (reads :: String -> [(Int, String)]) arg of
   [(maxAbs, _)] -> askForNumbers . (System.Random.randomRs :: (Int, Int) -> System.Random.StdGen -> [Int]) (-maxAbs, maxAbs) $ randGen
   _ -> putStrLn . ("Can't parse " ++) . (arg ++) $ " as Int."
  _ -> printUsage
 return ()

askForNumbers :: [Int] -> IO ()
askForNumbers [] = return ()
askForNumbers (number : _) = do
 putStrLn . show $ number
 return ()

printUsage :: IO ()
printUsage = do
 progName <- System.Environment.getProgName
 putStrLn "Usage"
 putStrLn . ("$ " ++) . (progName ++) $ "<max absolute number>"

