import Control.Monad

main :: IO ()
main = do
  n <- readLn :: IO Int
  str <- replicateM n getLine
  let ans = map (sum . map read . words) str
  mapM_ print ans
