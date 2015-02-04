-- Enter your code here. Read input from STDIN. Print output to STDOUT
import Control.Monad
import Data.List

-- sort, then count repeating characters
-- only one (!) count can be odd, all the other must be even
-- so only interested in odd counts
-- can fold then and return cound of odd counts, if it's > 1, then answer is NO

detect :: String -> String
-- detect str = if length (filter (\x -> odd (length x)) (group (sort str))) <= 1
  -- then "YES" else "NO"

detect str = if length (filter (odd . length) (group (sort str))) <= 1
    then "YES" else "NO"

main :: IO ()
main = do
    line <- getLine
    let ans = detect line
    putStrLn ans
