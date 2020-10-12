-- |
-- Module      :  Cards
-- Description :  Home work assigment for Week 1: check credit card numbers
-- Copyright   :  erlnow 2020 - 2030
-- License     :  BSD3
--
-- Maintainer  :  erlestau@gmail.com
-- Stability   :  experimental
-- Portability :  unknown
--
-- For validate a Credit Card most providers rely on a checksum formula
-- for distinguishing valid numbers from random collections.
-- In this library 'validate' check if a number is a valid credit card
-- number.
--
-- This is the first assignment for week 1 of /Yorgey's cis194 course/.
--
-- The assignment can be read on
-- <https://www.seas.upenn.edu/~cis194/spring13/hw/01-intro.pdf>
-- 
-- Note to run tests:
--
-- @
--      $ cabal new-run spec
-- @
--
-- or in @ghci@:
--
-- @
--      $ cabal new-repl spec
--      ghci> hspec CardsSpec.spec
-- @

module Cards (
             -- **Exercise 1
             -- $ex1
               toDigits, toDigitsRev
             -- **Exercise 2
             -- $ex2
             , doubleEveryOther
             -- **Exercise 3
             -- $ex3
             , sumDigits
             -- **Exercise 4
             -- $ex4
             , validate
  ) where

-- $intro
-- For validate a /credit card number/:
--
-- * Double the value of every second digit beginning from the right.
--   That is, the last digit is unchanged; the second-to-last digit
--   is doubled; the third-to-last is unchanged; and so on. For example
--   [1,3,8,6] becomes [2,3,16,6]
-- * Add the digits of the double values and the undoubled digits from
--   the original number. For example, @[2,3,16,6]@ becomes
--   @2+3+1+6+6=18@.
-- * Calculate the remainder when the sum is divided by 10. For the
--   above example, the remainder would be 8.
--
-- If the result is 0, then the number is valid.

-- $ex1
-- We need to first find the digits of a number. Define the functions
--
-- @
-- toDigits    :: Integer -> [Integer]
-- toDigitsRev :: Integer -> [Integer]
-- @

-- |'toDigits' converts positive Integers to a list of digits. 'toDigitsRev'
-- should do the same, but with digit reversed.
--
-- >>> toDigits 1234 == [1,2,3,4]
-- True
-- >>> toDigitsRev 1234 == [4,3,2,1]
-- True
-- >>> toDigits 0 == []
-- True
-- >>> toDigits (-17) == []
-- Tue
toDigits :: Integer -> [Integer]
toDigits  = reverse . toDigitsRev

-- |Converts a reversed positive Integer to digits
toDigitsRev :: Integer -> [Integer]
toDigitsRev n | n <= 0 = []
              | otherwise = n `mod` 10 : toDigitsRev (n `div` 10)

-- $ex2
-- Once we have the digits in the proper order, we need to
-- double every other one. Define a function
--
-- @
-- doubleEveryOther :: [Integer] -> [Integer]
-- @

-- |Doubles every other number /beginning from the right/, that is, 
-- second-to-last, fourth-to-last, ... numbers are doubled.
--
-- >>> doubleEveryOther [8,7,6,5]
-- [16,7,12,5]
-- >>> doubleEveryOther [1,2,3]
-- [1,4,3]
doubleEveryOther :: [Integer] -> [Integer]
doubleEveryOther xs = (reverse . doubleEveryOther' . reverse) xs 
  where doubleEveryOther' []       = []
        doubleEveryOther' [x]      = [x]
        doubleEveryOther' (x:y:ns) = x : 2*y : doubleEveryOther' ns

-- $ex3
-- The output of doubleEveryOther has a mix of one-digit
-- and two-digit numbers. Define the function
--
-- @
-- sumDigits :: [Integer] -> Integer
-- @
--
-- to calculate the sum of all digits.
-- 
-- Example:
--
-- >>> sumDigits [16,7,12,5] == 1 + 6 + 7 + 1 + 2 + 5

-- |Calculates the sum of all digits of a list of Integers.
--
-- Note: The list has numbers with one digit and two digits.
-- Numbers with two-digits are the doubles of one digit number
sumDigits :: [Integer] -> Integer
sumDigits ns = sum [if x > 9 then sum2dig x else x | x <- ns]
                      where sum2dig n = n `div` 10 + n `mod` 10
          -- previously I have write:
          -- @sum [if x > 9 then x `mod` 9 else x | x <- ns]@
          -- but failed when @x == 9@ or @x == 18@, in this case
          -- @9 `mod` 9 == 0@ or
          -- @18 `mod` 9 == 0@
          -- the first case i don't know why, @9 > 9 == False@
          -- the second case comes from doubleEveryOther and
          -- i had not think this case

-- $ex4
-- Define the function
--
-- @
-- validate :: Integer -> Bool
-- @
--
-- that indicates whether an 'Integer' could be a valid credit
-- card number. This will use all functions defined in the previous
-- exercises.
-- Examples
--
-- >>> validate 4012888888881881 == True
-- >>> validate 4012888888881882 == False

-- |Indicates whether an 'Integer' could be a valid credit
-- card number.
validate :: Integer -> Bool
validate n = (sumDigits . doubleEveryOther . toDigits) n `mod` 10 == 0
