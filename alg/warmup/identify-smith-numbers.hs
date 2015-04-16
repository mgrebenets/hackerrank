import Control.Monad
import Data.Char

-- sumDigits :: [Int] -> Int
sumDigits n = sum $ map digitToInt $ show n

primesSieve n = sieve [2..n]
    where
        sieve [] = []
        sieve (p:xs) = p : sieve [x | x <- xs, x `mod` p > 0]

-- round or ceiling?
intSqrt = floor . sqrt . fromIntegral

squeeze n p
    | n `mod` p == 0 = (fst rec, p : (snd rec))
    | otherwise = (n, [])
        where
            rec = squeeze (n `div` p) p

-- wrong, matches for loop only, needs a nested while loop
primeFactors n i primes =
    -- let (r, factors) = foldl (\(n, acc) p -> if n `mod` p == 0 then (n `div` p, acc) else (n, acc ++ [p])) (n , i) primes
    let (r, factors) = foldl (\(n, acc) p -> (fst (squeeze n p), acc ++ (snd (squeeze n p)))) (n , i) primes
    in factors ++ [r | r > 1]

-- http://en.wikipedia.org/wiki/Trial_division
trialDivision n
    | n < 2 = []
    | otherwise = primeFactors n [] smallPrimes
        where
            primes = primesSieve n
            smallPrimes = takeWhile (\p -> p * p <= n) primes

main :: IO ()
main = do
    n <- readLn :: IO Int
    let factors = trialDivision n
    let ans = if sumDigits n == sum (map sumDigits factors) then 1 else 0
    print ans
