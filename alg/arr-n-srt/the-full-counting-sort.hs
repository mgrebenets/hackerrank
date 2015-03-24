import Control.Monad
import Data.Array.IO
import Data.Array
import Data.Array.Base (unsafeThaw, thaw)
import Data.List

-- convert element string into a tuple of int and string values
readElement e = (n, s)
    where
        arr = words e
        n = read (head arr) :: Int
        s = last arr

-- 99 is the max int input, so code below is OK
count :: [(Int, String)] -> [(Int, Int)]
count input = assocs . accumArray (+) 0 (0, 99) . map (\(i, s) -> (i, 1)) $ input

-- countLessThan = mapAccumL (\acc (x, c) -> (acc + c, (x, acc + c))) 0

-- split :: [a] -> ([a], [a])
split l = (take half l, drop half l)
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
-- placeElement :: Int -> String -> IO (IOArray Int Int) -> IO (IOArray Int (Int, String)) -> [Int] -> Int
placeElement num s outArr lessThanCounts diffsArr = do
    let lessThanCount = lessThanCounts!num
    curDiff <- readArray diffsArr num
    let placeIndex = lessThanCount - curDiff
    writeArray outArr placeIndex s
    writeArray diffsArr num (curDiff - 1)
    return Nothing

-- smartCountingSort :: [(Int, String)] -> [Int] -> m (Int, (t0, String))
smartCountingSort list = do
    let listLen = length list
    let countsLen = 100
    let countsArr = accumArray (+) 0 (0, pred countsLen) . map (\(i, s) -> (i, 1)) $ list
    print "done countsArr"
    let lessThanCountsList = snd (mapAccumL (\acc (x, c) -> (acc + c, (x, acc + c))) 0 (assocs countsArr))
    print "done lessThanCountsList"
    let lessThanCountsArr = listArray (0, pred countsLen) (map snd lessThanCountsList)
    print "done lessThanCountsArr"

    outArr <- newArray (0, pred listLen) "-" :: IO (IOArray Int String)
    print "done outArr"

    -- this looks like to be the costly part
    -- find a way to reduce this step, e.g. get the counts as part of getting less than counts
    diffsArr <- unsafeThaw countsArr :: IO (IOArray Int Int)
    print "done diffsArr"

    let (fstHalf, sndHalf) = split list
    print "done split"

    forM_ fstHalf $ \(num, s) -> do
        placeElement num "-" outArr lessThanCountsArr diffsArr
        return Nothing

    print "done 1st half"

    forM_ sndHalf $ \(num, s) -> do
        -- print (num, s)
        placeElement num s outArr lessThanCountsArr diffsArr
        return Nothing

    print "done 2nd half"

    x <- getElems outArr
    print "done get elems"
    return (unwords x)

    -- return Nothing



-- -- smartCountingSort :: [(Int, String)] -> [Int] -> m (Int, (t0, String))
-- smartCountingSort list counts lessThanCounts = do
--     let len = length list
--     outArr <- newArray (0, pred len) "-" :: IO (IOArray Int String)
--     -- print "done outArr"
--     -- shiftArr <- newArray (0, pred len) 0 :: IO (IOArray Int Int)
--     -- let zippedCounts = zip counts (0:counts)
--     -- let diffsList = map (uncurry (-)) zippedCounts
--     diffsArr <- newListArray (0, pred (length counts)) (map snd counts) :: IO (IOArray Int Int)
--     -- print "done diffsArr"
--     let lessThanCountsArr = listArray (0, pred (length lessThanCounts)) lessThanCounts
--     -- print lessThanCountsArr
--     -- print "done lessThanCountsArr"
--     let (fstHalf, sndHalf) = split list
--     -- print "done split"
--
--     forM_ fstHalf $ \(num, s) -> do
--         placeElement num "-" outArr lessThanCountsArr diffsArr
--         return Nothing
--
--     -- print "done 1st half"
--
--     forM_ sndHalf $ \(num, s) -> do
--         -- print (num, s)
--         placeElement num s outArr lessThanCountsArr diffsArr
--         return Nothing
--
--     -- print "done 2nd half"
--
--     x <- getElems outArr
--     -- print "done get elems"
--     return (unwords x)
--
--     -- return Nothing


main :: IO ()
main = do
    n <- readLn :: IO Int
    list <- replicateM n getLine
    let input = map readElement list
    -- let lessThanCountsArr = mapAccum (\acc (x, c) -> (acc + c, (x, acc + c))) 0 countsArr
    smartSorted <- smartCountingSort input
    -- putStrLn smartSorted
    print "---"


    -- let counts = count input
    -- -- print counts
    -- -- print "done counts"
    -- let lessThanCounts = map snd (snd (countLessThan counts))
    -- -- print lessCounts
    -- -- print "done less counts"
    -- smartSorted <- smartCountingSort input counts lessThanCounts
    -- -- print "done"
    -- putStrLn smartSorted
