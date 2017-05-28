-- Project Euler, Problem 41
-- https://projecteuler.net

import Data.Numbers.Primes
import Data.List

toInt :: [Int] -> Int
toInt ds = sum $ zipWith (*) (zipWith (^) (repeat 10) [0..]) ds

largestPandigitalPrime =
  maximum $ head $ dropWhile (null) $
  map (filter isPrime . map toInt) $
  map (\x -> permutations [1..x]) [9,8..1]

main :: IO ()
main = print largestPandigitalPrime
