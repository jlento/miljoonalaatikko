-- Project Euler, Problem 12
-- https://projecteuler.net

-- Prime factorization could be made faster by using the fact that
-- we can immediately factor triangle numbers to two large factors
-- by using the triangle number formula T(n) = n * (n + 1) / 2

import Data.Numbers.Primes
import Data.List

triangleNumber :: Int -> Int
triangleNumber n = div (n * (n + 1)) 2

numberOfFactors :: Int -> Int
numberOfFactors =
  length . nub . subsequences . primeFactors

main :: IO ()
main = case (find ((500<) . numberOfFactors . triangleNumber) [1..]) of
  Just n -> print $ triangleNumber n
  Nothing -> undefined
