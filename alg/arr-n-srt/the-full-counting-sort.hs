import Control.Monad
import Data.Array
import Data.Array.IO
import Data.List

-- convert element string into a tuple of int and string values
readElement e = (n, s)
    where
        arr = words e
        n = read (head arr) :: Int
        s = last arr

count :: [(Int, String)] -> [(Int, Int)]
count input = assocs . accumArray (+) 0 (0, 99) . map (\(i, s) -> (i, 1)) $ input

countLessThan = mapAccumL (\acc (x, c) -> (acc + c, (x, acc + c))) 0

-- split :: [a] -> ([a], [a])
split l = (take half l, drop (half + adj) l)
  where
    len = length l
    half = div len 2
    adj = mod len 2

-- what's going on here
-- countingSort is curried, first argument is list (l)
-- then resuting function expectes counts, which is an array of (elem, count) tuples
-- so what does it do to tuples
-- it applices concatMap, which maps the function (uncurry $ flip replicate) over each tuple
-- and concatenates results into 1 list
-- the (uncurry $ lifp replicate) does the following
-- (uncurry $ flip replicate) is just another way to say (uncurry (flip replicate))
-- uncurry converts curried function to a function on pairs
-- in another words it converts f x y into f (x, y)
-- that suggests that (flip replicate) is a curried function
-- and it is because flip f x y = f y x
-- so flip takes a function as input and returns "flipped" function
-- x and y are curried
-- thus uncurry turns it to flip f x y = f (y, x)
-- and once uncurried it then accepts pairs of (a, b) and that's exactly what is in counts array
-- so what the hell is flip replicate in the first place?
-- it should take (0, 6) and turn it into list of 0s repeated 6 times
-- replicate N x repeats x N times, so replicate (0, 6) would not work the way we want it
-- first of all it would not get the tuple, but uncurrying takes care of that
-- so flip doesn't work on args level, but "alters" the way function takes args in
countingSort l = concatMap (uncurry $ flip replicate)


-- placeElement :: (Int, String) -> m (a Int Int) -> m (a Int String) -> Array Int Int -> (Int, String)
placeElement num s shiftArr outArr countsArr = do
    writeArray outArr placeIndex (num, s)
    writeArray shiftArr num (shiftArr!num + 1)
    -- return (num, s)
    return 0
    where
        placeIndex = lessThanCount - 1 - shiftArr!num
        lessThanCount = countsArr!num

-- smartCountingSort :: [(Int, String)] -> [Int] -> m (Int, (t0, String))
smartCountingSort list counts = do
    map (\(num, s) -> placeElement num s shiftArr outArr countsArr) list
    -- return outArr
    return outArr
    -- return (0, "")
    where
        outArr = newArray (0, len - 1) (-1, "")
        shiftArr = newArray (0, len - 1) 0
        countsArr = listArray (0, length counts - 1) counts
        len = length list


main :: IO ()
main = do
    n <- readLn :: IO Int
    list <- replicateM n getLine
    let input = map readElement list
    let (fstHalf, sndHalf) = split input
    print input
    print "---"
    print fstHalf
    print sndHalf
    print "---"
    let counts = count input
    print counts
    print "---"

    print (countLessThan counts)
    print "---"
    print (map snd (snd (countLessThan counts)))
    print "---"

    let sorted = countingSort input counts
    print sorted
    print "---"

    let lessCounts = map snd (snd (countLessThan counts))
    let smartSorted = smartCountingSort input lessCounts
    -- print smartSorted
    print "---"

    -- have the counts, now need to go through them and accumulate a new array
    -- for each count, take the second value in the tuple and sum it up with accumulated value and put result into resulting array
    -- let ans = map snd (snd (countLessThan counts))
    -- putStr $ unwords (map show ans)
