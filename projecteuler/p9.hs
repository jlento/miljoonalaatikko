-- Project Euler, Problem 9
-- https://projecteuler.net

import Data.List

type Triplet = (Int, Int, Int)

floorSquare :: Int -> Int
floorSquare n = truncate $ sqrt (fromIntegral n :: Double)


triplets :: [Triplet]
triplets = [(a, b, floorSquare (a^2 + b^2)) |
            b <- [1..],
            a <- [1..(b-1)],
            c <- [a^2 + b^2],
            c == (floorSquare c)^2]

tripletSum :: Triplet -> Int
tripletSum = \(a,b,c) -> a + b + c

tripletProduct :: Triplet -> Int
tripletProduct = \(a,b,c) -> a * b * c

tripletProductOfSumOf :: Int -> Maybe Triplet
tripletProductOfSumOf n = find ((n ==) . tripletSum) triplets

main :: IO ()
main = case tripletProductOfSumOf s of
  Just x -> print $ tripletProduct x
  Nothing -> print $ "Did not find a triplet with a sum of " ++ show s
  where s = 1000
