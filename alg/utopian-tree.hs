-- Enter your code here. Read input from STDIN. Print output to STDOUT
import Control.Monad

utopianTree n
| n == 0 = 1
| mod n 2 == 0 = utopianTree(n - 1) + 1
| otherwise = 2 * utopianTree(n - 1)

main :: IO ()
main = do
  n <- readLn :: IO Int
  -- read all the lines (replicateM)
  line <- replicateM n getLine
  -- map all the read lines to results by applying utopian tree function
  let ans = map utopianTree ((map read line) :: [Integer])
  mapM_ print ans
