import Control.Monad
import qualified Data.Vector as V
import Data.List

powers m = map (2^) [0..m]

twotwo ps acc [] = acc
twotwo ps acc l@(x:xs) = twotwo ps newAcc xs
    where
        -- newAcc = acc + foldl' (\acc p -> if p `isPrefixOf` l then acc + 1 else acc) 0 ps
        newAcc = foldl' (\acc p -> acc + 1) acc ps        

main :: IO ()
main = do
    n <- readLn :: IO Int
    testCases <- replicateM n getLine
    -- print testCases
    let maxPower = 800
    let powerStrings = map show (powers maxPower)
    let ans = map (twotwo powerStrings 0) testCases
    -- print ans
    mapM_ print ans
    -- mapM_ (print . sum) ans
