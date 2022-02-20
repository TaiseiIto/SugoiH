{-# OPTIONS -Wall -Werror #-}

import qualified Data.Map

data LockerState = Taken | Free deriving (Show, Eq)

type Code = String

type LockerMap = Data.Map.Map Int (LockerState, Code)

lockers :: LockerMap
lockers = Data.Map.fromList
 [
  (100, (Taken, "ZD39I")),
  (101, (Free, "JAH3I")),
  (103, (Free, "IQSA9")),
  (105, (Free, "QOTSA")),
  (109, (Taken, "893JJ")),
  (110, (Taken, "99292"))
 ]

lockerLookup :: Int -> LockerMap -> Either String Code
lockerLookup lockerNumber lockerMap =
 case Data.Map.lookup lockerNumber lockerMap of
 Nothing -> Left $ "Locker " ++ show lockerNumber ++ " doesn't exist!"
 Just (state, code) ->
  if state /= Taken
  then Right code
  else Left $ "Locker " ++ show lockerNumber ++ " is already taken!"

