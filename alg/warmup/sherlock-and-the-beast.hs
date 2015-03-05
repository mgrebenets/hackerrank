import Control.Monad
import Data.Char

-- gcd n 3 == 3 --> fill with 5s
-- else: gcd n 5 == 5 --> fill with 3s
-- else substract 5 (this counds towards number of 3s) and repeat the process

-- a should be greater than b (e.g. decentCounts n 5 3)
-- decentCounts :: Int -> Int -> (Int, Int) -> Int -> (Int, Int)
decentCounts a b (acc_a, acc_b) n
  | n == 0 = (acc_a, acc_b)
  | n < b = (0, 0)
  | gcd n b == b = (acc_a + n, acc_b)
  | otherwise = decentCounts a b (acc_a, acc_b + a) (n - a)

repeatDigit :: Int -> Int -> String
repeatDigit n c = (concat . replicate c) [intToDigit n]

stringify :: Int -> Int -> (Int, Int) -> String
stringify a b (x, y)
  | x == 0 && y == 0 = "-1"
  | otherwise = repeatDigit a x ++ repeatDigit b y

main :: IO ()
main = do
  n <- readLn :: IO Int
  list <- replicateM n getLine
  let inputs = map read list :: [Int]
  -- print inputs
  let counts = map (decentCounts 5 3 (0, 0)) inputs
  let ans = map (stringify 5 3) counts
  mapM_ putStrLn ans
