-- |
-- Module      :  IntroSpec
-- Copyright   :  erlnow 2020 - 2030
-- License     :  BSD3
--
-- Maintainer  :  erlestau@gmail.com
-- Stability   :  experimental
-- Portability :  unknown
--
-- Test of module 'Intro'
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
--      ghci> hspec IntroSpec.spec
-- @

module IntroSpec (spec) where

import Intro
import Test.Hspec
import Test.QuickCheck

spec :: Spec
spec = do
  describe "Intro" $ do
    it "sumtorial 1000" $ do
      sumtorial 1000 `shouldBe` 1000 * (1000 + 1) `div` 2
    it "sumtorial n" $ property $
      \x -> if x<0 then True -- skip negative numbers
                   else sumtorial x == x * (x+1) `div` 2

  describe "foo" $ do
    it "foo 0" $ do 
      foo 0 `shouldBe` 16
    it "foo 1 " $ do
      foo 1 `shouldBe` 3
    it "foo 36" $ do
      foo 36 `shouldBe` (-43)
    it "foo 38" $ do 
      foo 38 `shouldBe` (38 + 3)

  describe "foo" $ do
    it "isEven 2" $ do
      isEven 2 `shouldBe` True
    it "isEven 3" $ do
      isEven 3 `shouldBe` False
      
  describe "sumPair" $ do
    it "sumPair (x,y) == x + y" $ property $
      \x -> (\y -> sumPair (x,y) == x + y)

  describe "f" $ do
    it "f x y z = x+y+z" $ property $
      \x -> (\y -> (\z -> f x y z == x+y+z))
    it "f x y z = sumPair (sumPair(x,y),z)" $ property $
      \x -> (\y -> (\z -> f x y z == sumPair(sumPair(x,y),z)))
    it "f x y z = sumPair (x,sumPair(y,z))" $ property $
      \x -> (\y -> (\z -> f x y z == sumPair(x,sumPair(y,z))))

  describe "Collatz conjeture" $
    it "end in [4,2,1]" $ property $
      \n -> if n > 0 && hailstoneLen n > 3
             then take 3 (reverse (hailstoneSeq n)) == ([1,2,4] :: [Integer])
             else True
    
