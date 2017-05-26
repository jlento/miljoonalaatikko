-- Project Euler, Problem 7
-- https://projecteuler.net
-- $ cabal install primes

import Data.Numbers.Primes

main :: IO ()
main =print $ (primes!!10000 :: Integer)
