isPalindrome a = reverse (show a) == show a

main = print $
  maximum $ filter isPalindrome [x * y | x <- [900..999], y <- [900..x]]
