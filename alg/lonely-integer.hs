-- Enter your code here. Read input from STDIN. Print output to STDOUT
import Control.Monad
import Data.List

--unique :: [Int] -> Int
unique list = head (head (filter (\x -> length x == 1) (group (sort list))))
-- taking head 2 times, because I have no idea how to flatten nested list easily atm :)

readNumbers :: String -> [Int]
readNumbers = map read . words

main :: IO ()
main = do
  n <- readLn :: IO Int
  line <- getLine
  let ans = unique (readNumbers line)
  print ans
