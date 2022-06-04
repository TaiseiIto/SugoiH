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

fsTo :: Name -> FSZipper -> Maybe FSZipper
fsTo name (Folder folderName items, bs) = let (ls, item : rs) = Data.List.break (nameIs name) items in Just (item, FSCrumb folderName ls rs : bs)
fsTo _    (File _ _,                _)  = Nothing

fsUp :: FSZipper -> Maybe FSZipper
fsUp (item, FSCrumb name ls rs : bs) = Just (Folder name $ ls ++ [item] ++ rs, bs)
fsUp (_   , [])                      = Nothing

fsRename :: Name -> FSZipper -> FSZipper
fsRename newName (Folder _ items, bs) = (Folder newName items, bs)
fsRename newName (File   _ dat,   bs) = (File   newName dat,   bs)

fsNewFile :: FSItem -> FSZipper -> Maybe FSZipper
fsNewFile item (Folder folderName items, bs) = Just (Folder folderName (item : items), bs)
fsNewFile _    (File _ _,                _)  = Nothing

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

unJust :: Maybe FSZipper -> FSZipper
unJust (Just z) = z
unJust Nothing  = (File "" "", [])

newFocus :: FSZipper
newFocus = unJust $ do
 pos0 <- fsTo "pics" . zipFS $ myDisk
 fsTo "skull_man(scary).bmp" pos0

newFocus2 :: FSZipper
newFocus2 = unJust $ do
 pos0 <- fsUp newFocus
 fsTo "watermelon_smash.gif" pos0

newFocus3 :: FSZipper
newFocus3 = unJust $ do
 pos0 <- fsTo "pics" . zipFS $ myDisk
 pos1 <- fsNewFile (File "heh.jps" "lol") . fsRename "cspi" $ pos0
 fsUp pos1

main :: IO ()
main = do
 putStrLn . show $ newFocus
 putStrLn . show $ newFocus2
 putStrLn . show $ newFocus3

