{-# OPTIONS -Wall -Werror #-}

import qualified Data.List

infixl 0 -:
(-:) :: a -> (a -> b) -> b
x -: f = f x

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

fsRename :: Name -> FSZipper -> FSZipper
fsRename newName (Folder _ items, bs) = (Folder newName items, bs)
fsRename newName (File   _ dat,   bs) = (File   newName dat,   bs)

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

newFocus :: FSZipper
newFocus = myDisk -: zipFS -: fsTo "pics" -: fsTo "skull_man(scary).bmp"

newFocus2 :: FSZipper
newFocus2 = newFocus -: fsUp -: fsTo "watermelon_smash.gif"

newFocus3 :: FSZipper
newFocus3 = myDisk -: zipFS -: fsTo "pics" -: fsRename "cspi" -: fsUp

main :: IO ()
main = do
 putStrLn . show $ newFocus
 putStrLn . show $ newFocus2
 putStrLn . show $ newFocus3

