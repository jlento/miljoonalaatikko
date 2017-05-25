-- Project Euler, Problem 15
-- https://projecteuler.net

-- Different ways to reach a point can be directly read from Pascal's triangle.

choose :: Int -> Int -> Int
choose _ 0 = 1
choose 0 _ = 0
choose n k = choose (n-1) (k-1) * n `div` k

pathsFromCornerToCorner :: Int -> Int
pathsFromCornerToCorner n = choose (2 * n) n

main :: IO ()
main = print $ pathsFromCornerToCorner 20
