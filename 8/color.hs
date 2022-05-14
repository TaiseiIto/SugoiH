{-# OPTIONS -Wall -Werror #-}

import qualified Control.Monad
import qualified System.IO

main :: IO ()
main = do
 System.IO.hSetBuffering System.IO.stdout System.IO.NoBuffering
 colors <- Control.Monad.forM ([1,2,3,4] :: [Int]) $ \a -> do
  putStr $ "Which color do you associate with the number " ++ show a ++ "? : "
  getLine
 putStrLn "The colors that you associate with 1, 2, 3, and 4 are :"
 mapM_ putStrLn colors
 return ()

