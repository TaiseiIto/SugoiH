{-# OPTIONS -Wall -Werror #-}

import qualified Data.List

type Name = String

type Data = String

data FSItem =
 File Name Data |
 Folder Name [FSItem]
 deriving Show

data FSCrumb = FSCrumb Name [FSItem] [FSItem] deriving Show

type FSZipper = (FSItem, [FSCrumb])

zipFS :: FSItem -> FSZipper
zipFS item = (item, [])

nameIs :: Name -> FSItem -> Bool
nameIs name (Folder folderName _) = name == folderName
nameIs name (File   fileName   _) = name == fileName

fsTo :: Name -> FSZipper -> FSZipper
fsTo name (Folder folderName items, bs) = let (ls, item : rs) = Data.List.break (nameIs name) items in (item, FSCrumb folderName ls rs : bs)
fsTo _    (File _ _,                _)  = error "Error @ fsTo"

fsUp :: FSZipper -> FSZipper
fsUp (item, FSCrumb name ls rs : bs) = (Folder name $ ls ++ [item] ++ rs, bs)
fsUp (_   , [])                      = error "Error @ fsUp"

myDisk :: FSItem
myDisk =
 Folder "root"
  [
   File "goat_yelling_like_man.wmv" "baaaaaa",
   File "pope_time.avi" "god bless",
   Folder "pics"
    [
     File "ape_throwing_up.jpg" "bleargh",
     File "watermelon_smash.gif" "smash!!",
     File "skull_man(scary).bmp" "Yikes!"
    ],
   File "dijon_poupon.doc" "best mustard",
   Folder "programs"
    [
     File "fartwizard.exe" "10gotofart",
     File "owl_bandit.dmg" "mov eax, h00t",
     File "not_a_virus.exe" "really not a virus",
     Folder "source code"
      [
       File "best_hs_prog.hs" "main = print (fix error)",
       File "random.hs" "main = print 4"
      ]
    ]
  ]

main :: IO ()
main = putStrLn . show . fsUp . fsTo "dijon_poupon.doc" . zipFS $ myDisk

