-- Project Euler, Problem 9
-- https://projecteuler.net

import Data.List

floorSquare n = truncate $ sqrt (fromIntegral n :: Double)

triplets :: [(Int,Int,Int)]
triplets = [(a, b, floorSquare (a^2 + b^2)) | b <- [1..], a <- [1..(b-1)], (a^2 + b^2) == (floorSquare (a^2 + b^2))^2]

tripletSum = \(a,b,c) -> a + b + c
tripletProduct = \(a,b,c) -> a * b * c

tripletSumProduct n = case (find ((n ==) . tripletSum) triplets) of
           Just t -> tripletProduct t
           Nothing -> undefined
