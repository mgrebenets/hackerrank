-- Enter your code here. Read input from STDIN. Print output to STDOUT
import Control.Monad

chocolates xs = 1

main :: IO ()
main = do
  n <- readLn :: IO Int
  list <- replicateM n readLn :: IO [Int]
  let ans = chocolates list
  print  ans
