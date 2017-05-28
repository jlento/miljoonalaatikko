-- Project Euler, Problem 48
-- https://projecteuler.net

main :: IO ()
main = print $ sum $ zipWith (^) [1..1000] [1..1000]
