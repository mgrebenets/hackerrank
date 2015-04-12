import Control.Monad
import qualified Data.Vector as V

readNumbers :: String -> [Int]
readNumbers = map read . words

readInput [a, b] = (a, b)

minVehicle lanes (i, j) = V.minimum s
    where
        s = V.slice i (j - i + 1) lanes

main :: IO ()
main = do
    input <- getLine
    let (n, t) = readInput (readNumbers input)
    input <- getLine
    let lanes = V.fromList (readNumbers input)
    -- print lanes
    testsInput <- replicateM t getLine
    let tests = map (readInput . readNumbers) testsInput
    -- print tests
    let ans = map (minVehicle lanes) tests
    mapM_ print ans
