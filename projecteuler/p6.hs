-- Project Euler, Problem 6
-- https://projecteuler.net
-- $ cabal install natural-numbers

import Data.Natural

squareOfSumOfNatUpTo n = n^2 * (n + 1)^2 `div` 4
sumOfSquaresOfNatUpTo n = n * (n + 1) * (2 * n + 1) `div` 6
