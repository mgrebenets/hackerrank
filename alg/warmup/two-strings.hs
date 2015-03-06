import Control.Monad
import Data.List
import Data.Set (Set)
import qualified Data.Set as Set

readNumbers :: String -> [Int]
readNumbers = map read . words

-- convert is fast no matter what's the conversion
-- this one converts from [String] to [(Set Char, Set Char)]
convert [] = []
convert (k:v:t) = (Set.fromList k, Set.fromList v) : convert t

-- this is slow if working with lists and trying to intersect them
-- with sets it's fast
-- haveSubstring :: (Set Char, Set Char) -> String
haveSubstring (p, q) = if Set.null (p `Set.intersection` q) then "NO" else "YES"

main :: IO ()
main = do
  n <- readLn :: IO Int
  list <- replicateM (n * 2) getLine
  let tests = convert list
  -- print tests
  let ans = map haveSubstring tests
  mapM_ putStrLn ans
