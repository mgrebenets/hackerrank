import Control.Monad
import Data.List

readNumbers :: String -> [Int]
readNumbers = map read . words

readPair [a, b] = (a, b)
readTriple [a, b, k] = (a, b, k)

comparator (r1, k1) (r2, k2) = if r1 /= r2 then r1 `compare` r2 else r2 `compare` r1
main :: IO ()
main = do
    input <- getLine
    let (n, m) = readPair $ readNumbers input
    input <- replicateM m getLine
    let ranges = map (readTriple . readNumbers) input
    let marks = foldl' (\acc (a, b, k) -> acc ++ [(a, k)] ++ [(b, -k)]) [] ranges
    let sortedMarks = sortBy comparator marks
    let initialAns = map (snd . snd) $ zip [1..2 * m] sortedMarks
    let foldedAns = sort $ scanl' (+) 0 initialAns
    print $ last foldedAns
