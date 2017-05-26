-- Project Euler, Problem 17
-- https://projecteuler.net

-- cabal install numerals

import Data.Char
import qualified Data.Text as T
import Text.Numeral.Grammar
import Text.Numeral.Language.ENG
import Control.Monad

toNumeral :: Int -> Maybe T.Text
toNumeral n = case gb_cardinal defaultInflection n of
  Just s -> Just $ T.replace (T.pack "hundred ")(T.pack "hundred and ") s
  Nothing -> Nothing

countLetters :: T.Text -> Int
countLetters = length . filter isLetter . T.unpack

countLettersInNumeralsUpTo :: Int -> Maybe Int
countLettersInNumeralsUpTo n =
  liftM (sum . map countLetters) $ mapM toNumeral [1..n]

main :: IO ()
main = print $ countLettersInNumeralsUpTo 1000

