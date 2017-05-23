-- Project Euler, Problem 10
-- https://projecteuler.net

import Data.Numbers.Primes

answer = sum $ takeWhile (<2000000) primes