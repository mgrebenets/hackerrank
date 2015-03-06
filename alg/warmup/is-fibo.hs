import Control.Monad

-- so the idea is to follow wiki
-- http://en.wikipedia.org/wiki/Fibonacci_number#Recognizing_Fibonacci_numbers
-- and this http://math.stackexchange.com/questions/9999/checking-if-a-number-is-a-fibonacci-or-not
-- n is fibo if (5*n^2 + 4) or (5*n^2 - 4) is perfect square
-- for square test check sherlock and squares implementation

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

isSquare :: Integer -> Bool
isSquare x = sr * sr == x where sr = isqrt x

isFibo n = if isSquare (t - 4) || isSquare (t + 4) then "IsFibo" else "IsNotFibo"
  where t = 5 * (n ^ 2)

main :: IO ()
main = do
  n <- readLn :: IO Int
  list <- replicateM n getLine
  -- must be Integer, not Int, or some values will overflow
  let numbers = map read list :: [Integer]
  -- print numbers
  let ans = map isFibo numbers
  mapM_ putStrLn ans
