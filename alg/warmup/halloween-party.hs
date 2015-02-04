import Control.Monad

-- sample output
-- 6
-- 9
-- 12
-- 16

pieces k = h * v
  where
    v = div k 2
    h = v + mod k 2

main :: IO ()
main = do
  n <- readLn :: IO Int
  list <- replicateM n getLine
  let inputs = map read list :: [Int]
  let ans = map pieces inputs
  mapM_ print ans
