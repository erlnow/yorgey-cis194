{-# OPTIONS_GHC -Wno-overlapping-patterns #-}
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

Beyond enumerations
-------------------

`FailableDouble` type has two data constructor. The first one,
`Failure`, takes no arguments, so `Failure` by itself is a value
of type `FailableDouble`. The second one, `OK`, takes an argument
of type `Double`. So `OK` by itself is not a value of type
`FailableDouble`; we need it a `Double`.

> -- |A 'FailableDouble' can be a 'Failure' or a 'OK' 'Double'. 
> data FailableDouble = Failure
>                     | OK Double
>      deriving Show
>
> exD1, exD2 :: FailableDouble
> -- | Example of a 'FailableDouble' variable
> exD1 = Failure
> -- | Another example of a 'FailableDouble' variable
> exD2 = OK 3.4

Thought exercise: What is the type of `OK`?
	
   `OK` is a function that takes a `Double` and
   returns a `FailableDouble` value. 

   ~~~
   OK :: Double -> FailableDouble
   ~~~

> -- |'safeDiv' returns the result of the division or 'Failure'
> -- if the denominator is \(0\).
> safeDiv :: Double -> Double -> FailableDouble
> safeDiv _ 0 = Failure
> safeDiv x y = OK (x/y)

> -- |Returns 0 if 'Failure', the 'Double' in any other case.
> failureToZero :: FailableDouble -> Double
> failureToZero Failure = 0
> failureToZero (OK d)  = d

Data constructors can have more than one argument.

> -- | Store a person's name, age and favourite 'Thing'
> data Person
>      = Person  
>        String  -- ^ name
>        Int     -- ^ age
>        Thing   -- ^ Favourite 'Thing'
>      deriving Show
> 
> -- |A boy
> brent :: Person
> brent = Person "Brent" 31 SealingWax
>
> -- |An old person
> stan :: Person
> stan = Person "Stan" 94 Cabbage
>
> -- |Gets the age of a 'Person'
> -- 
> -- >>> getAge brent + 50 < getAge stan
> -- True
> getAge :: Person -> Int
> getAge (Person _ a _) = a

Algebraic data types in general
-------------------------------

In general, an algebraic data type has one or more data constructors,
and each data constructor can have zero or more arguments.

    data AlgDataType = Constr1 Type11 Type12
                     | Constr2 Type21
                     | Constr3 Type31 Type32 Type33
                     | Constr4

Type and data constructor names must always start with a capital letter.

Pattern-matching
----------------

> -- |Example of @x\@pat@ to match a pattern @pat@ and give the name
> -- @x@ to the entire value being matched.
> baz :: Person -> String
> baz p@(Person n _ _) = "The name field of (" ++ show p ++ ") is " ++ n

> -- |Example of *nested* patterns
> checkFav :: Person -> String
> checkFav (Person n _ SealingWax) = n ++ ", you're my kind of person!"
> checkFav (Person n _ _)          = n ++ ", your favorite thing is lame."

Case expression
---------------

> -- | Example of @case@ expression
> --
> -- Note:
> -- Warns about "Pattern match is redundant"
> -- In a case alternative: [] ->
> -- In a case alternative: _  ->
> exCase :: Int
> exCase = case "Hello" of
>            []      -> 3
>            ('H':s) -> length s
>            _       -> 7

The syntas for defining functions we have seen is really just convenient
syntax sugar for defining a `case` expression. For example:

> -- | Alternative definition of 'failureToZero' using a @case@ expresion.
> failureToZero' :: FailableDouble -> Double
> failureToZero' x = case x of
>                      Failure -> 0
>                      OK d    -> d

Recursive data types
--------------------

Data types can be *recursive*, that is, defined in terms of themselves.
In fact, we have already seen a recursive type---the type of lists.
A list is either empty, or a single element followed by a remaning list.
We could define our own list type like so:

> -- | A list of 'Int' as recursive algrebraic data type
> data IntList = Empty | Cons Int IntList
>
> -- | Product of all elements in a 'IntList'
> intListProd :: IntList -> Int
> intListProd Empty      = 1
> intListProd (Cons x l) = x * intListProd l

> -- | A example of recursive algebaric data type. A binary tree holding
> -- an 'Int' in its nodes and a 'Char' in its leaves.
> data Tree = Leaf Char
>           | Node Tree Int Tree
>      deriving Show

> -- | A tree
> tree :: Tree
> tree = Node (Leaf 'x') 1 (Node (Leaf 'y') 2 (Leaf 'z'))
