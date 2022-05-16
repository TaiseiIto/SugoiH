{-# OPTIONS -Wall -Werror #-}

type PhoneNumber = String
type Name = String
type PhoneBook = [(Name, PhoneNumber)]

phoneBook :: PhoneBook
phoneBook =
 [
  ("betty", "555-2938"),
  ("bonnie", "452-2928"),
  ("patsy", "493-2928"),
  ("lucille", "205-2928"),
  ("wendy", "939-8282"),
  ("penny", "853-2492")
 ]

inPhoneBook :: Name -> PhoneNumber -> PhoneBook -> Bool
inPhoneBook _ _ [] = False
inPhoneBook name phoneNumber ((phoneBookHeadName, phoneBookHeadPhoneNumber) : phoneBookTail)
 | (name, phoneNumber) == (phoneBookHeadName, phoneBookHeadPhoneNumber) = True
 | otherwise = inPhoneBook name phoneNumber phoneBookTail

