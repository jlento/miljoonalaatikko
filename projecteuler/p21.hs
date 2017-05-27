-- Project Euler, Problem --
-- https://projecteuler.net

-- cabal install primes

import Data.Numbers.Primes
import Data.List

properDivisors :: Integer -> [Integer]
properDivisors = init . map product . nub . subsequences . primeFactors

sumOfProperDivisors :: Integer -> Integer
sumOfProperDivisors = sum . properDivisors

isAmicableNumber :: Integer -> Bool
isAmicableNumber x =
  x == sumOfProperDivisors (sumOfProperDivisors x) &&
  x /= sumOfProperDivisors x &&
  x /= 1

sumOfAmicableNumbersUnder :: Integer -> Integer
sumOfAmicableNumbersUnder x = sum $ filter isAmicableNumber [1..(x-1)]

main :: IO ()
main = print $ sumOfAmicableNumbersUnder 10000
