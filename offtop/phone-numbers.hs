import Control.Monad
import qualified Data.Trie as Trie
import qualified Data.ByteString as ByteString
import qualified Data.Map as Map

-- dictionary in /usr/share/dict/words

-- getLines = liftM lines . readFile
-- read dictionary
-- readDic path = fmap Text.lines (Text.readFile path)
-- readDic :: FilePath -> IO [String]
-- readDic :: FilePath -> [ByteString]
readDic :: FilePath -> ByteString.ByteString
readDic path = do
                contents <- ByteString.readFile path
                return contents

readSystemDic = readDic "/usr/share/dict/words"

-- digitForLetter :: Char -> String
-- digitForLetter l = "1"
--
-- -- matchingNumber :: String -> String
-- matchingNumber = foldr((++) .digitForLetter) ""
--
-- trieList = map (\x -> (x, matchingNumber x))
--
-- dicTrie = Trie.fromList . trieList

-- get letters for corresponding digit
-- getLetters digit = lookup digit keymap
--     where
--         keymap = Map.fromList [("0", " "), ("1", ""), ("2", "abc"), ("3", "edf"), ("4", "ghi"), ("5", "jkl"), ("6", "mno"), ("7", "pqrs"), ("8", "tuv"), ("9", "wxyz")]

-- find words for the number in dictionary
findWords :: String -> String
-- findWords numbers
findWords (x:xs) = "W"
findWords [] = ""

    -- where
        -- dic = readDic


main :: IO ()
main = do
  n <- readLn :: IO Int
  numbers <- replicateM n getLine
  let sysDic = readSystemDic
  ByteString.putStrLn sysDic
  -- let trie = dicTrie sysDic
  let ans = map findWords numbers
  mapM_ print ans
