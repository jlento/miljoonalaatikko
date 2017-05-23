-- Project Euler, Problem 5
-- https://projecteuler.net

-- Theorem: Any positive integer X that is evenly divisible by
--   all positive integers up to N is of the form X = C * I, where C is
--   the product of all primes <= N, and I is a positive integer

import Data.List
import Data.Natural

isPrime :: Natural -> Bool
isPrime 1 = False
isPrime 2 = True
isPrime x = and $ map ((0 /=) . rem x) [2..(x-1)]

isDivisibleByAll :: [Natural] -> Natural -> Bool
isDivisibleByAll xs y = and $ map ((0 ==) . rem y) xs

divisibleByAll :: Natural -> Maybe Natural
divisibleByAll x = find (isDivisibleByAll [1..x]) [1*c,2*c..]
  where c = product $ filter isPrime [1..x]
