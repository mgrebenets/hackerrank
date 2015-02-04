import Control.Monad

-- samples 2 0

readNumbers :: String -> [Int]
readNumbers = map read . words

readInputs [a, b] = (a, b)

-- ternary operator
data Cond a = a :? a

infixl 0 ?
infixl 1 :?

(?) :: Bool -> Cond a -> a
True  ? (x :? _) = x
False ? (_ :? y) = y

isqrt 0 = 0
isqrt 1 = 1
isqrt n = head $ dropWhile (\x -> x*x > n) $ iterate (\x -> (x + n `div` x) `div` 2) (n `div` 2)

isSquare :: Int -> Bool
isSquare x = sr * sr == x where sr = isqrt x

intSqrt x = (floor . sqrt) (fromIntegral x :: Double)
squares (a, b) = (intSqrt b - intSqrt a) + (isSquare a ? 1 :? 0)

main :: IO ()
main = do
  n <- readLn :: IO Int
  list <- replicateM n getLine
  let inputs = map (readInputs . readNumbers) list
  -- print inputs
  let ans = map squares inputs
  mapM_ print ans


-- Not used, keep for reference
-- import Data.Array
-- import qualified Data.Foldable as DF

-- foldra :: (a -> b -> b) -> b -> Array1D a -> b
-- foldra f z0 ar = go (lo ar)
--   where go i
--     | i > hi ar = z0
--     | otherwise = f (ar ! i) (go (i + 1))

-- type Array1D a = Array Int a
-- -- and two utility functions for getting the lower and upper bounds
-- lo,hi :: Array1D a -> Int
-- lo = fst . bounds
-- hi = snd . bounds


-- foldl'a :: (b -> a -> b) -> b -> Array1D a -> b
-- foldl'a f z0 ar = go z0 (lo ar)
--   where go !z i
--     | i > hi ar = z
--     | otherwise = go (f z (ar ! i)) (i + 1)


-- checkSquares = DF.foldr' (\x -> (+) (isSquare x ? 1 :? 0)) 0
-- checkSquares = DF.foldr' (\x -> (+) isqrt) 0

-- squares (a, b) = checkSquares [a..b]
-- squares (a, b) = checkSquares (listArray (0, b - a) [a..b])

-- isSquare x = let x' = floor $ sqrt (fromIntegral x :: Double) in x'*x' == x
