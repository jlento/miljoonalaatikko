-- Project Euler, Problem 6
-- https://projecteuler.net

-- $ cabal install natural-numbers

import Data.Natural

squareOfSumOfNatUpTo :: Natural -> Natural
squareOfSumOfNatUpTo n = n^2 * (n + 1)^2 `div` 4

sumOfSquaresOfNatUpTo :: Natural -> Natural
sumOfSquaresOfNatUpTo n = n * (n + 1) * (2 * n + 1) `div` 6

main :: IO ()
main = print $ squareOfSumOfNatUpTo 100 - sumOfSquaresOfNatUpTo 100
