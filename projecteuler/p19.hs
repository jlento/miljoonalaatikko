-- Project Euler, Problem 19
-- https://projecteuler.net

type Year = Int
data Month = Jan
           | Feb
           | Mar
           | Apr
           | May
           | Jun
           | Jul
           | Aug
           | Sep
           | Oct
           | Nov
           | Dec
           deriving (Eq, Ord, Enum, Show)

type Day = Int
data Date = Date { weekday :: Weekday,
                   year :: Year,
                   month :: Month,
                   day :: Day} deriving (Eq, Ord, Show)

data Weekday = Monday
             | Tuesday
             | Wednesday
             | Thursday
             | Friday
             | Saturday
             | Sunday
             deriving (Eq, Ord, Enum, Show)

daysInMonth :: Year -> Month -> Int
daysInMonth y m = [31, feb y, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]!!im
  where im = fromEnum m
        feb n
          | rem n 400 == 0 = 29
          | rem n 100 == 0 = 28
          | rem n 4 == 0 = 29
          | otherwise = 28

nextDate :: Date -> Date
nextDate (Date w y m d)  = Date (toEnum nw) ny (toEnum nm) nd
  where nd = rem d (daysInMonth y m) + 1
        nm = rem (if nd < d then (fromEnum m) + 1 else (fromEnum m)) 12
        ny = if nm < (fromEnum m) then y + 1 else y
        nw = toEnum $ rem ((fromEnum w) + 1) 7

datesFrom :: Date -> [Date]
datesFrom d = d : datesFrom (nextDate d)

isSundayFirst :: Date -> Bool
isSundayFirst d = weekday d == Sunday && day d == 1

main :: IO ()
main =
  print $ length $ takeWhile ((2001>) . year) $ dropWhile ((1901>) . year) $ filter isSundayFirst $ datesFrom (Date Monday 1900 Jan 1)
