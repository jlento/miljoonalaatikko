-- Project Euler, Problem 14
-- https://projecteuler.net

import Data.List

type CollatzNumberAndLength = (Int, Int)

collatz :: Int -> [Int]
collatz n
  | n == 1 = [1]
  | otherwise = n : if even n
                    then collatz (div n 2)
                    else collatz (3 * n + 1)

collatzLength :: Int -> CollatzNumberAndLength
collatzLength n = (n, (length . collatz) n)

compareCollatzLength :: CollatzNumberAndLength -> CollatzNumberAndLength -> Ordering
compareCollatzLength (_ ,l1) (_, l2) = compare l1 l2

main :: IO ()
main = print $ fst $ maximumBy compareCollatzLength $ map collatzLength [1..1000000]

