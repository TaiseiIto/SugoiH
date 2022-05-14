{-# OPTIONS -Wall -Werror #-}

main :: IO ()
main = interact $ unlines . filter (\line -> length line < 10) . lines

