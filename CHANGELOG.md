# Revision history for yorgey-cis194

## 0.2.0.0 -- 2020-10-26 02-ADTs

### Added

* doc/02-ADTs.lhs       -- Week 2: Algebraic Data Types lecture 
* src/ADTs.lhs          -- same as above as a module

### Changed 

Fix doctest

* src/Hanoi.hs                  -- Fix doctest and comment about pending implement `reeve`
* src/Cards.hs                  -- Fix doctest

Fix Hspec test

* test/cis194/HanoiSpec.hs      -- comment `reeve` test and use pendingWith instead

New version 

* CHANGELOG.md
* package.yaml
* yorgey-cis194.cabal

## 0.1.0.1 -- 2020-10-26 01-Intro

### Added
* doc/style.pdf
* doc/01-intro.lhs
* doc/images/pure.jpg
* doc/images/relax.jpg
* doc/images/static.jpg
* doc/images/function-machine.png
* doc/images/haskell-logo-small.png
* src/Intro.lhs
* test/cis194/Spec.hs
* test/cis194/IntroSpec.hs
* src/Cards.hs
* test/cis194/CardsSpec.hs
* app/cccn.hs

### Changed
* package.yaml
* yorgey-cis194.cabal
* CHANGELOG.md

## 0.1.0.0 -- 2020-10-07

First version. Skeleton of a project:

* .gitignore
* CHANGELOG.md
* LICENSE
* README.md
* Setup.hs
* hie.yaml
* package.yaml
* yorgey-cis194.cabal
* app/Main.hs
* src/MyLib.hs
* test/MyLibTest.hs
