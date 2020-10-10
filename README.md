# Yorgey CIS 194
u

Chris Allen (a.k.a. [bytemyapp][b]), one of the authors of [Haskell
Book][hbook], wrote an [article][htlh] about his recommended path to _learn
Haskell_.

Between others online resources, he mentions [Brent Yorgey][yorgey]'s course
_CIS 194_, available [online][cis194].

> Do _this first_ if aren't getting the Haskell Book, this is the best _free_
  introduction to Haskell.

In this [repository][repo], I will try follow this course and the proposed exercises.

---
[b]: https://github.com/bitemyapp
[hbook]: http://haskellbook.com/
[htlh]: https://github.com/bitemyapp/learnhaskell
[yorgey]: https://byorgey.wordpress.com/
[cis194]: http://www.seas.upenn.edu/~cis194/spring13/
[repo]: https://github.com/erlnow/yorgey-cis194

## Test

TODO: write about testing with Hspec, QuickCheck and doctest and
the error about ">prop" with doctest and how to solve it, if finally i can

~~~~
> --
> -- $
> -- prop> sumtorial n == n + sumtorial (n-1)
> -- Two errors
> -- * if n < 0 sumtorial doesn't stop (Hspec + QuickCheck)
> -- * Exection 
> --
> --     @
> --       Variable not in scope:
> --         wkName
> --           :: [Char]
> --              -> template-haskell-2.11.1.0:Language.Haskell.TH.Syntax.Name
> --     @
> -- To solve: read https://github.com/phadej/cabal-doctest
~~~~

