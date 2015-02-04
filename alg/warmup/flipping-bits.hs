-- Enter your code here. Read input from STDIN. Print output to STDOUT
import Control.Monad
import Data.Bits
import Data.Word

main :: IO ()
main = do
  n <- readLn :: IO Int
  arr <- replicateM n getLine
  let ans = map complement (map read arr :: [Word32])
  mapM_ print ans
