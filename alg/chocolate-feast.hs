-- Enter your code here. Read input from STDIN. Print output to STDOUT
import Control.Monad

-- sample: 6 3 5

readNumbers :: String -> [Int]
readNumbers = map read . words

readInputs [n, c, m] = (n, c, m)

buy = div

exchange w m
  | w == 0 = 0
  | w < m = 0
  | otherwise = chocs + exchange (chocs + mod w m) m where chocs = div w m

feast (n, c, m) = chocs + exchange chocs m where chocs = buy n c

main :: IO ()
main = do
  n <- readLn :: IO Int
  list <- replicateM n getLine
  let inputs = map (readInputs . readNumbers) list
  -- print inputs
  let ans = map feast inputs
  mapM_ print ans
