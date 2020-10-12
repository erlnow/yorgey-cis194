-- |
-- Module      :  Hanoi
-- Description :  Home work assigment for Week 1: Towers of Hanoi
-- Copyright   :  erlnow 2020 - 2030
-- License     :  BSD3
--
-- Maintainer  :  erlestau@gmail.com
-- Stability   :  experimental
-- Portability :  unknown
--
-- Homework 1, exercise 5 Towers of Hanoi
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
--      ghci> hspec HanoiSpec.spec
-- @

module Hanoi (
             -- **Exercise 5
             -- $ex5
               Peg, Move, hanoi
             -- **Exercise 6
             -- $ex6
             , reeve
) where

-- $ex5
-- TODO: how to embed images in Haddock using local files? ![Towers of
-- Hanoi](hanoi.jpg)
--
-- The /Towers of Hanoi/ is a classic puzzle with a solution that can be
-- described recursively. Disk of different sizes are stacked on three pegs;
-- the goal is to get from a starting configuration with all disks stacked on
-- the last peg, as shown in Figure 1(TODO: add image)
--
-- The only rules are
--
-- * you may only move one disk at a time, and
-- * a larger disk may never be stacked on top of a smaller one.
--
-- For example, as the first move all you can do is move the topmost, smallest
-- disk onto a different peg, since only one disk may be moved at a time.
--
-- From this point, is /illegal/ to move to the configuration shown in Figure
-- 3(TODO: add image), because you are not allowed to put the green disk on top
-- of the smaller blue one.
--
-- To move \(n\) discs (stacked in increasing size) from peg \(a\) to peg \(b\)
-- using peg \(c\) as temporary storage,
--
-- 1.   move \(n - 1\) discs from \(a\) to \(c\) using \(b\) as temporary storage
-- 2.   move the top disc from \(a\) to \(b\)
-- 3.   move \(n - 1\) discs for \(c\) to \(b\) using \(a\) temporary storage.
--
-- For this exercise, define a function 'hanoi' with the following type:
--
-- @
-- type Peg = String
-- type Move = (Peg, Peg)
-- hanoi :: Integer -> Peg -> Peg -> Peg -> [Move]
-- @
--
-- Given the number of discs and the names for the three pegs, 'hanoi' should
-- return a list of moves to be perfomed to move the stack of disc form the
-- firs peg to the second.
--
-- Note that a type declaration, like @type Peg = String@ above, makes a /type
-- synonym/. In this case 'Peg' is declared as a synonym for 'String', and the
-- two names 'Peg' and 'String' can now be used interchangeably. Giving more
-- descriptive names to types in this way can be used to give shorted names to
-- complicated types, or (as here) simply to help with documentation.
--
-- Example:
--
-- >>> hanoi 2 "a" "b" "c" == [("a","c"),("a","b"),("c","b)]

-- |Name of peg
type Peg = String

-- |a move from one peg to other
type Move = (Peg, Peg)

-- |move @n@ discs from first peg to second using the last as temporary storage
hanoi :: Integer -> Peg -> Peg -> Peg -> [Move]
hanoi n a b c
  | n <= 0    = []
  | otherwise = (hanoi (n-1) a c b) ++ [(a,b)] ++ (hanoi (n-1) c b a)

-- $ex6
-- __(Optional)__ What if there are four pegs instead of three?  That is, the
-- goal is still move a stack of discs from th e first peg to the last peg,
-- whithout ever placing a larger disc on top of a smaller one, but now there
-- are two extra pegs that can be used as "temporary" storage instead of only
-- one. Write a function similar to 'hanoi' which solves this problem in as few
-- moves as posible.  It should be possible to do it in far fewer moves than
-- with three pegs. For example, with three pegs it takes \(2^15 - 1 = 32767)
-- moves to transfer 15 discs. With four pegs it can be done in 129 moves.
-- (See Exercise 1.17 in Graham, Knuth, and Patashnik, /Concrete Mathematics/,
-- second ed., Addison-Wesley, 1994)

-- |reeve's puzzle, like hanoi but with four pegs.
reeve :: Integer -> Peg -> Peg -> Peg -> Peg -> [Move]
reeve = undefined
