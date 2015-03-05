import Control.Monad
import Data.Char (digitToInt)

-- with great help from haskell linter got this curried function
-- it takes an int number n and then can take a string which is [Char]
-- so it will fold the array of chars, converting each character to int
-- checking if it's not 0 and if it divides the number with no remainder
-- in that case return 1 to add to accumulator (fold uses + as operation)
-- otherwise return 0
-- initial value is 0

compute n = foldr (\x -> (+)(if digitToInt x > 0 && mod n (digitToInt x) == 0 then 1 else 0)) 0

findDigits s = compute num s
  where
    num = read s :: Int

main :: IO ()
main = do
  n <- readLn :: IO Int
  list <- replicateM n getLine
  -- print list
  let ans = map findDigits list
  mapM_ print ans
