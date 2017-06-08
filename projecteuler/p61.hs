-- Project Euler, Problem --
-- https://projecteuler.net

import Data.List

triangle n = div (n*(n+1)) 2
square n = n * n
pentagonal n = div (n*(3*n-1)) 2
hexagonal n = n*(2*n-1)
heptagonal n = div (n*(5*n-3)) 2
octagonal n = n*(3*n-2)

take4digits = takeWhile (10000>) . dropWhile (1000>) . (flip map [1..])

s3 = take4digits triangle
s4 = take4digits square
s5 = take4digits pentagonal
s6 = take4digits hexagonal
s7 = take4digits heptagonal
s8 = take4digits octagonal

perm = map (s3:) $ permutations [s4, s5, s6, s7, s8]

consMatching :: [Int] -> [[Int]] -> [[Int]]
consMatching xs yss =
  [ x:ys | x <- xs, ys <- yss, rem x 100 == div (head ys) 100]

main :: IO ()
main = print $
  head $ map sum $
  filter (\x -> rem (last x) 100 == div (head x) 100) $
  concat $
  map (
  \p ->
    consMatching (p !! 0) $
    consMatching (p !! 1) $
    consMatching (p !! 2) $
    consMatching (p !! 3) $
    consMatching (p !! 4) (map (\x -> [x]) (p !! 5))) perm
