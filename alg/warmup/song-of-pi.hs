import Control.Monad
import Data.List

piString = "31415926535897932384626433833"

solve s = if s `isPrefixOf` piString then "It's a pi song." else "It's not a pi song."

main :: IO ()
main = do
    n <- readLn :: IO Int
    input <- replicateM n getLine
    let chars = map (map  (show . length) . words) input
    let strings = map concat chars
    let ans = map solve strings
    mapM_ putStrLn ans
