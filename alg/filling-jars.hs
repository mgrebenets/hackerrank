import Control.Monad
import Data.Array
import Data.List

readNumbers :: String -> [Int]
readNumbers = map read . words

handleOp acc op = acc + (b - a + 1) * k
  where
    a = opArr!0
    b = opArr!1
    k = opArr!2
    opArr = listArray (0, m - 1) op
    m = length op

average n ops = div (foldl' handleOp 0 ops) n

main :: IO ()
main = do
  line <- getLine
  let counts = readNumbers line
  let (n, m) = (head counts, last counts)
  opsLines <- replicateM m getLine
  let ops = map readNumbers opsLines
  let ans = average n ops
  print ans
