-- |
-- Module      :  HigerOrder
-- Description :  Home work assigment for Week 4: Higher Order Functions 
-- Copyright   :  erlnow 2020 - 2030
-- License     :  BSD3
--
-- Maintainer  :  erlestau@gmail.com
-- Stability   :  experimental
-- Portability :  unknown
--
-- CIS 194, Homework 4
-- 

-- Note to run tests:
-- @
--      $ cabal new-run spec
-- @
--
-- or in @ghci@:
--
-- @
--      $ cabal new-repl spec
--      ghci> hspec HanoiSpec.spec
-- @

module HigerOrder where

-- * Higer Order Functions
--
-- $text1
--
-- __What to turn in__: you should turn a single .hs (or .lhs), which
-- __must type check__.

-- ** __Exercise 1: Wholemeal programming__
--
-- $text2
--
-- Reimplement each of the following functions in a more idiomatic
-- Haskell style. Use /wholemeal programming/ practices, breaking
-- each function into a pipeline of incremental transformations to
-- an entire data structure. Name your functions @fun1'@ and @fun2'@
-- respectively.
--
-- @
--   fun1 :: [Integer] -> Integer
--   fun1 []       = 1
--   fun1 (x:xs)
--     | even x    = (x - 2) * fun1 xs
--     | otherwise = fun1 xs
--
--   fun2 :: Integer -> Integer
--   fun2 1             = 0
--   fun2 n | even n    = n + fun2 (n `div` 2)
--          | otherwise = fun2 (3*n + 1)
-- @
--
-- Hint: For this problem you may wish to use the functions
-- 'iterate' and 'takeWhile'. Look them up in the 'Prelude' documentation
-- to see what they do.

-- | fun1 function from exercise 1
fun1 :: [Integer] -> Integer
fun1 []       = 1
fun1 (x:xs)
 | even x    = (x - 2) * fun1 xs
 | otherwise = fun1 xs

-- | fun2 function from exercise 1
fun2 :: Integer -> Integer
fun2 1             = 0
fun2 n | even n    = n + fun2 (n `div` 2)
       | otherwise = fun2 (3*n + 1)

-- | /wholemeal programming/ version of 'fun1'
--
-- prop> fun1 xs == fun1' xs
fun1' :: [Integer] -> Integer
fun1' = product . map (subtract 2) . filter (even)

-- | /wholemeal programming/ version of 'fun2'
--
-- prop> fun2 n == fun2' n
fun2' :: Integer -> Integer
fun2' n = 
  let nextN m
       | even m    = m `div` 2
       | otherwise = 3*m + 1
  in sum . filter (even) . takeWhile (>1) $ iterate nextN n

-- ** __Exercise 2: Folding with trees__
-- 
-- $text3
--

-- ** __Exercise 3: More folds!__
--
-- $text4
--

-- ** __Exercise 4: Finding primes__
--
-- $text5
--
