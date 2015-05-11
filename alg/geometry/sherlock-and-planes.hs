import Control.Monad
import Data.List
import Data.List.Split

readNumbers :: String -> [Int]
readNumbers = map read . words

-- Super ugly and over-verbose
-- must be a much nicer and neater way to do all this
-- especially in haskell

-- http://tutorial.math.lamar.edu/Classes/CalcIII/EqnsOfPlanes.aspx
-- http://mathprofi.ru/uravnenie_ploskosti.html
-- pick 2 vectors based on any 3 points and check if those vectors are colinear
-- if they are, then this 3 points are on the same line in space
-- that means any 4th point will be on the same plane, just because it will actually define the plane
-- if those vectors are not colinear, then these 3 points define a plane
-- so create a plane equation and then test 4th point to check if it's on the same plane
-- it is true when 4th point's coordinates satisfy the plane equation

-- read point from array to tuple
readPoint [x, y, z] = (x, y, z)

-- vector multiplication
vectorMult (ax, ay, az) (bx, by, bz) = (ay * bz - az * by, ax * bz - az * bx, ax * by - ay * bx)

-- two vectors are colinear if their vector multiplication is 0
isColinear v1 v2 = vectorMult v1 v2 == (0, 0, 0)

-- vector define as difference of 2 points
vector (x1, y1, z1) (x2, y2, z2) = (x2 - x1, y2 - y1, z2 - z1)

-- determinant of 2x2 matrix
-- | a b |
-- | c d |
det a b c d = a * d - b * c

-- p4 belongs to the plane if plane equation based on p1, p2 and p3 is satisfied (equals to 0)
planeEquation (x, y, z) (x1, y1, z1) (x2, y2, z2) (x3, y3, z3) =
    (x - x1) * det my2 my3 mz2 mz3 - (y - y1) * det mx2 mx3 mz2 mz3 - (z - z1) * det mx2 mx3 my2 my3
    where
        mx2 = x2 - x1
        mx3 = x3 - x1
        my2 = y2 - y1
        my3 = y3 - y1
        mz2 = z2 - z1
        mz3 = z3 - z1

isPlane [p1, p2, p3, p4] =
    if isColinear v1 v2 || plane pt4 == 0 then "YES" else "NO"
    where
        pt1 = readPoint p1
        pt2 = readPoint p2
        pt3 = readPoint p3
        pt4 = readPoint p4
        v1 = vector pt1 pt2
        v2 = vector pt1 pt3
        plane = planeEquation pt1 pt2 pt3

main :: IO ()
main = do
    t <- readLn :: IO Int
    input <- replicateM (t * 4) getLine
    let tests = chunksOf 4 $ map readNumbers input
    let ans = map isPlane tests
    mapM_ putStrLn ans
