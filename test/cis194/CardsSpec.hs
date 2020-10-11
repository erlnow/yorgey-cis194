-- |
-- Module      :  CardsSpec
-- Copyright   :  erlnow 2020 - 2030
-- License     :  BSD3
--
-- Maintainer  :  erlestau@gmail.com
-- Stability   :  experimental
-- Portability :  unknown
--
-- Tests and use case for functions in 'Cards' module.
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

module CardsSpec (spec) where

import Test.Hspec
-- import Test.QuickCheck
import Cards

spec :: Spec
spec = do
  describe "Exercise 1" $ do
    it "toDigits 1234" $ do
      toDigits 1234 `shouldBe` [1,2,3,4]
    it "toDigitsRev 1234" $ do
      toDigitsRev 1234 `shouldBe` [4,3,2,1]
    it "toDigits 0" $ do
      toDigits 0 `shouldBe` ([] :: [Integer])
    it "toDigits (-17)" $ do
      toDigits (-17) `shouldBe` ([] :: [Integer])

  describe "Exercise 2" $ do
    it "doubleEveryOther [8,7,6,5]" $ do
      doubleEveryOther [8,7,6,5] `shouldBe` [16,7,12,5]
    it "doubleEveryOther [1,2,3]" $ do
      doubleEveryOther [1,2,3] `shouldBe` [1,4,3]

  describe "Exercise 3" $ do
    it "sumDigits [16,7,12,5]" $ do
      sumDigits [16,7,12,5] `shouldBe` 1 + 6 + 7 + 1 + 2 + 5

  describe "Exercise 4" $ do
    it "validate 4012888888881881" $ do
      validate 4012888888881881 `shouldBe` True
    it "validate 4012888888881882" $ do
      validate 4012888888881882 `shouldBe` False
