import Control.Monad

readTestCase = replicateM 2 getLine
parseTestCase [n, line] = (ni, linei)
  where
  ni = read n :: Int
  -- TODO: should it be an array?
  linei = map read (readNumbers line) :: [Int]

readNumbers = words

-- should not really care about ALL subsets, that's another case of trying
-- if there is a 1, the answer is YES right away
-- if there is no 1, then gcd should be used, but how...

-- ok, so the goal is to find 2 elements for which gcd is 0
-- as soon as these 2 are found, say YES
-- question is how to find these 2

-- answer - go left to right in optionally sorted array
-- if neighbours gcd is 0 - got the answer, if not, then the two have gcd
-- so can safely throw any of them out of the subset I'm looking for
-- so just drop the first and compare second to next in the list
-- and so on
-- just one pass, linear time

findGcd [] = "NO"
findGcd [x] = "NO"
findGcd (x:xs) = if gcd x (head xs) == 1 then "YES" else findGcd xs

subset (n, nums) = findGcd nums

main :: IO ()
main = do
  t <- readLn :: IO Int
  testCases <- replicateM t readTestCase
  let inputs = map parseTestCase testCases
  let ans = map subset inputs
  mapM_ putStrLn ans
