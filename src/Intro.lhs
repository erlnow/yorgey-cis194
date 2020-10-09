<!--
{-# OPTIONS_GHC -Wall #-}
-->

Haskel Basics
=============

This functions are copied from `doc/01-intro.lhs` and packed as a module.

> -- |
> -- Module : Intro
> -- Description: Yorgey's CIS 194, 01 Introduction to Haskell
> -- Copyright: (c) Eduardo Ramón Lestau, 2020
> -- LICENSE: BSD3
> -- Mantainer: erlestau@gmail.com
> -- Portability: POSIX
> -- 
> -- Functions defined in `01-Intro.lhs` packed as a module.
> --

> module Intro where


> -- $setup
> -- import Prelude

> -- |Compute the sum of the integers from 1 to n.
> --
> -- >>> sumtorial 1000
> -- 500500
> --
> -- -- doesn't work prop> (read . show) x == (x :: Int) 
> sumtorial :: Integer -> Integer
> sumtorial 0 = 0
> sumtorial n = n + sumtorial (n-1)

> -- |Example of /pattern matching/ with /guards/
> -- 
> -- >>> foo (-3)
> -- 0
> -- >>> foo 0
> -- 16
> -- >>> foo 36
> -- -43
> -- >>> foo 38
> -- 41 
> foo :: Integer -> Integer
> foo 0 = 16
> foo 1 
>   | "Haskell" > "C++" = 3
>   | otherwise         = 4
> foo n
>   | n < 0            = 0
>   | n `mod` 17 == 2  = -43
>   | otherwise        = n + 3

> -- isEven :: Integer -> Bool
> -- isEven n 
> --   | n `mod` 2 == 0 = True
> --   | otherwise      = False

This *works*, but it is much too complicated.  Can you see why?

> -- |Decides if a 'Integer' is even
> isEven :: Integer -> Bool
> isEven n = n `mod` 2 == 0

> -- |Sums the elements in a pair
> sumPair :: (Int,Int) -> Int
> sumPair (x,y) = x + y

> -- |Sum of three 'Int''s
> f :: Int -> Int -> Int -> Int
> f x y z = x + y + z

> -- |In a list of 'Integer's sums two by two the elements of 
> -- the list from the left. Returns the sums in a list
> --
> -- >>>sumEveryTwo [1,2,3,4,5]
> -- [3,7,5]
> sumEveryTwo :: [Integer] -> [Integer]
> sumEveryTwo []         = []     -- Do nothing to the empty list
> sumEveryTwo (x:[])     = [x]    -- Do nothing to lists with a single element
> sumEveryTwo (x:(y:zs)) = (x + y) : sumEveryTwo zs

> -- |Computes the /hailstone number/ 
> hailstone :: Integer -> Integer
> hailstone n
>   | n `mod` 2 == 0 = n `div` 2
>   | otherwise      = 3*n + 1

> -- |Compute the length of a list of Integers.
> intListLength :: [Integer] -> Integer
> intListLength []     = 0
> intListLength (_:xs) = 1 + intListLength xs

> -- |Generate the sequence of hailstone iterations from a starting number.
> hailstoneSeq :: Integer -> [Integer]
> hailstoneSeq 1 = [1]
> hailstoneSeq n = n : hailstoneSeq (hailstone n)

> -- |The number of hailstone steps needed to reach 1 from a starting
> -- number.
> hailstoneLen :: Integer -> Integer
> hailstoneLen n = intListLength (hailstoneSeq n) - 1
