{-# OPTIONS -Wall -Werror #-}

main :: IO ()
main = interact $ unlines . map (\string -> if string == reverse string then "palindrome" else "not a palindrome") . lines

