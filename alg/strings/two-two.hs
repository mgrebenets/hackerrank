import Control.Monad
import qualified Data.Vector as V
import Data.List

powers m = map (2^) [0..m]

-- TODO: opti-fucking-mize the next recursive call
-- TODO: ask why referring to acc makes it so slow
-- TODO: figure out if thiw whole method could be implemented
-- with foldl instead of manually defining recursion

twotwo ps acc [] = acc
twotwo ps acc l@(x:xs) = twotwo ps newAcc xs
    where
        -- using acc anywhwere here makes it extremely slow
        -- as if it unfolds whole recursion somehow...
        -- newAcc = acc + foldl' (\a p -> if p `isPrefixOf` l then a + 1 else a) 0 ps
        -- newAcc = foldl' (\a p -> if p `isPrefixOf` l then a + 1 else a) acc ps
        -- newAcc = acc + foldr (\p a -> if p `isPrefixOf` l then a + 1 else a) acc ps
        -- newAcc = foldl' (\a p -> a) 0 ps
        newAcc = acc + foldl' (\a p -> a + 1) 0 ps
        -- newAcc = foldr (\p a -> a) acc ps        

main :: IO ()
main = do
    n <- readLn :: IO Int
    testCases <- replicateM n getLine
    -- print testCases
    let maxPower = 800
    let powerStrings = map show (powers maxPower)
    print powerStrings
    let ans = map (twotwo powerStrings 0) testCases
    -- print ans
    mapM_ print ans
    -- mapM_ (print . sum) ans
