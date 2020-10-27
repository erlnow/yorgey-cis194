Algrebraic data types
=====================

CIS 194 Week 2  
21 January 2013

Suggested reading:

  * [Real World Haskell](http://book.realworldhaskell.org/),
    chapters 2 and 3

> -- |
> -- Module : ADTs
> -- Description: Yorgey's CIS 194, 02 Algrebraic Data Types
> -- Copyright: (c) Eduardo Ramón Lestau, 2020
> -- LICENSE: BSD3
> -- Mantainer: erlestau@gmail.com
> -- Portability: POSIX
> -- 
> -- Definitions in `02-ADTs.lhs` as a module
> --
> module ADTs where

Enumeration types
-----------------

> -- |'Thing' is a simple enumeration of things
> data Thing = Shoe
> 	     | Ship
> 	     | SealingWax
> 	     | Cabbage
> 	     | King
>            deriving Show

We can define variables of type `Thing`:

> -- |A shoe
> shoe :: Thing
> shoe = Shoe
>
> -- | My favourite 'Thing's.
> listO'Things :: [Thing]
> listO'Things = [Shoe, SealingWax, King, Cabbage, King]

We can write functions on `Thing`s by *pattern-matching*.

> -- |Given a 'Thing' returns 'True' if is a small 'Thing' or 'False'
> -- otherwise.
> -- 
> -- Example
> --
> -- >>> map isSmall listO'Things
> -- [True,True,False,True,False]
> isSmall :: Thing -> Bool
> isSmall Ship = False
> isSmall King = False
> isSmall _    = True


