import Data.Bits (xor)

maxXor :: Int -> Int -> Int
maxXor l r = maximum [xor a b | b <- [l..r], a <- [l..b]]
-- this is same as a `xor` b, use backticks to put function in infix position

main :: IO ()
main = do
  l <- readLn
  r <- readLn
  print $ maxXor l r
