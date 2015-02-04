-- Enter your code here. Read input from STDIN. Print output to STDOUT
import Control.Monad
import Data.Char (ord)

-- Imperative: find the middle (excluding odd element optionally) then proceed to the ends getting difference each step
-- Functional: same, but first split, accounting for odd element
-- (didn't get the split part right), tried below (but doesn't work)
-- split [] = ([], [])
-- split [x] = ([], []) -- this drops odd middle element
-- split (x:xs:y) = (x:xp, yp:y) where (xp, yp) = split xs
-- the do element diff of 2 splits, but don't forget to reverse one of them
-- then take the abs of diffs and sum them up

split :: String -> (String, String)
split l = (take half l, drop (half + adj) l)
  where
    len = length l
    half = div len 2
    adj = mod len 2

listDiff :: (String, String) -> Int
listDiff (l, r) = sum (map abs (zipWith (-) (map ord l) (map ord (reverse r))))

minPalindrome :: String -> Int
minPalindrome list = listDiff (split list)

main :: IO ()
main = do
  n <- readLn :: IO Int
  arr <- replicateM n getLine
  --  let s = map split arr
  --  mapM_ print s
  let ans = map minPalindrome arr
  mapM_ print ans
