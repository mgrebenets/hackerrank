import Control.Monad

readNumbers :: String -> [Int]
readNumbers = map read . words

cnv :: [[Int]] -> [(Int, [Int])]
cnv [] = []
cnv (k:v:t) = (last k, v) : cnv t

countOnTime = foldr (\x sum -> if x <= 0 then sum + 1 else sum) 0

cancelClass :: (Int, [Int]) -> String
cancelClass (s, times) = if onTimeCount < s then "YES" else "NO"
  where onTimeCount = countOnTime times

main :: IO ()
main = do
  n <- readLn :: IO Int
  list <- replicateM (n * 2) getLine
  let inputs = map readNumbers list
  let tests = cnv inputs
  let ans = map cancelClass tests
  mapM_ putStrLn ans
