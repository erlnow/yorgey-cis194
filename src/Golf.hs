-- |
-- Module      :  Golf
-- Description :  Homework assignment 3
-- Copyright   :  erlnow 2020 - 2030
-- License     :  BSD3
--
-- Maintainer  :  erlestau@gmail.com
-- Stability   :  experimental
-- Portability :  unknown
--
-- Homework assignment 3 from Yorgey's CIS 194

module Golf where

-- * Code Golf!
--
-- $hw
--
-- This assignment is simple: there are three tasks listed below. For each
-- task, you should submit a Haskell function with the required name and type
-- signature which accomplishes the given task and is /as short as possible/.
--
-- original pdf is placed in @doc/03-rec-poly.lhs@.
--
-- ** Exercise 1 Hopscotch
--
-- $ex1
--
-- Your first task is to write a function
--
-- @
--   skips :: [a] -> [[a]]
-- @
--
-- The output of 'skips' is a list of list. The first list in the output should
-- be the same as the input list. The second list in the output should contain
-- every second from the input list...and the /n/th list in the output should
-- contain every /n/th element from the input list.
--
-- For example:
--
-- >>> skips "ABCD"   == ["ABCD", "BD", "C", "D" ]
-- True
-- >>> skips "hello!" == ["hello!", "el!", "l!", "l", "o", "!"]
-- True
-- >>> skips [1]      == [[1]]
-- True
-- >>> skips []       == []
-- True
--
-- Solution:
--
-- If we have a function that returns every /n/th element of a list, given @n@
-- between @1@ and @length l@ and being @l@ the input list the solution is
-- straightforward. My solution is a list comprehension where from @1@ to the
-- length of @l@ I generate the element using my function to skip every @i@th
-- element of the input list.
--
-- 'every' drops @n-1@ elements and call itself recursively to choose next
-- /n/th element, building the list using the __cons__ operator @:@.

-- |function that expects a list and return a list of lists. The first element
-- is always the input list, the second element contains every second from the
-- input list, until the last element that contains the /n/th element.
skips :: [a] -> [[a]]
skips []  = []
skips xs  = [ every xs i | i <- [1..length xs]]

-- |returns a list formed by elements to the given list every @n@ positions.
every :: [a] -> Int -> [a]
every l n = case drop (n-1) l of
                (y:ys) -> y : every ys n
                []     -> []

-- ** Exercise 2 Local maxima
--
-- $ex2
--
-- /local maximum/ of a list is an element of the list which is strictly
-- greater than both the elements immediately before and after it. For
-- example, in the list @[2,3,4,1,5]@, the only local maximum is 4, since
-- it is greater than the elements immediately before and after it (3 and
-- 1). 5 is not a local maximum since there is no element that comes after
-- it.
--
-- Write a function
--
-- @
-- localMaxima :: [Integer] -> [Integer]
-- @
--
-- which finds all the local maxima in the input list and returns them in order.
-- For example:
--
-- >>> localMaxima [2,9,5,6,1]
-- [9,6]
-- >>> localMaxima [2,3,4,1,5]
-- [4]
-- >>> localMaxima [1,2,3,4,5]
-- []
--
-- Solution:
--
-- This version is a recursive solution. It checks for a local maxima in the
-- three first elements of @xs@: @x@, @y@ and @z@. If not it continues
-- searching for a local maxima in the tail of @xs@. If the second is a local
-- maximum it use cons operator and continues searching for the rest of
-- elements of xs, z cannot be a local maximum this time. 

-- |Returns a list of local maximum in a given list of 'Integer's.
localMaxima :: [Integer] -> [Integer]
localMaxima (x:y:z:xs)
  | x < y && z < y      = y : localMaxima (z:xs)
  | otherwise           = localMaxima (y:z:xs)
localMaxima []          = []
localMaxima [_]         = []
localMaxima [_,_]       = []
