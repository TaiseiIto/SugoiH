data Person = Person
 String -- First name
 String -- Last name
 Int    -- Age
 Float  -- Height
 String -- Phone number
 String -- Favorite ice cream flavor
 deriving (Show)

firstName :: Person -> String
firstName (Person _firstName _ _ _ _ _) = _firstName

lastName :: Person -> String
lastName (Person _ _lastName _ _ _ _) = _lastName

age :: Person -> Int
age (Person _ _ _age _ _ _) = _age

height :: Person -> Float
height (Person _ _ _ _height _ _) = _height

phoneNumber :: Person -> String
phoneNumber (Person _ _ _ _ _phoneNumber _) = _phoneNumber

flavor :: Person -> String
flavor (Person _ _ _ _ _ _flavor) = _flavor

