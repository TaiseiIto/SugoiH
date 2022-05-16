{-# OPTIONS -Wall -Werror #-}

data Person = Person
 {
  firstName :: String,
  lastName  :: String,
  age       :: Int
 }
 deriving
 (
  Eq,
  Read,
  Show
 )

mikeD :: Person
mikeD = Person
 {
  firstName = "Michael",
  lastName  = "Diamond",
  age       = 43
 }

adRock :: Person
adRock = Person
 {
  firstName = "Adam",
  lastName  = "Horovitz",
  age       = 41
 }

mca :: Person
mca = Person
 {
  firstName = "Adam",
  lastName  = "Yauch",
  age       = 44
 }

mysteryDude :: String
mysteryDude = "Person{firstName = \"Michael\", lastName = \"Diamond\", age = 43}"

