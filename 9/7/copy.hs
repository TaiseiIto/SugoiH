{-# OPTIONS -Wall -Werror #-}

import qualified Control.Exception
import qualified Data.ByteString
import qualified System.Directory
import qualified System.Environment
import qualified System.IO

copy :: String -> String -> IO ()
copy src dst = do
 contents <- Data.ByteString.readFile src
 Control.Exception.bracketOnError
  (
   System.IO.openTempFile "." "temp"
  )
  (
   \(tempName, tempFile) -> do
    System.IO.hClose tempFile
    System.Directory.removeFile tempName
  )
  (
   \(tempName, tempFile) -> do
    Data.ByteString.hPutStr tempFile contents
    System.IO.hClose tempFile
    System.Directory.renameFile tempName dst
  )

main :: IO ()
main = do
 args <- System.Environment.getArgs
 case args of
  [src, dst] -> copy src dst
  _          -> printUsage
 return ()

printUsage :: IO ()
printUsage = do
 progName <- System.Environment.getProgName
 putStrLn $ "Usage : ./" ++ progName ++ " <source> <destination>"

