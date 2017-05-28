-- Project Euler, Problem 32
-- https://projecteuler.net

-- a x b = c
-- a < b < c
-- (1)  _ x _ _ _ _ = _ _ _ _
-- (2)  _ _ x _ _ _ = _ _ _ _

import Data.List

isPandigitalProduct [i1,i2,i3,i4,i5,i6,i7,i8,i9] =
  i1 * (1000*i2 + 100*i3 + 10*i4 + i5) == (1000*i6 + 100*i7 + 10*i8 + i9) ||
  (10*i1 + i2) * (100*i3 + 10*i4 + i5) == (1000*i6 + 100*i7 + 10*i8 + i9)

sumOfPandigitalProducts =sum $ nub $
  map (\[_,_,_,_,_,i6,i7,i8,i9] -> 1000*i6 + 100*i7 + 10*i8 + i9) $
  filter isPandigitalProduct $
  permutations [1..9]

main :: IO ()
main = print sumOfPandigitalProducts
