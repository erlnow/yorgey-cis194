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
      \x -> (read . show) x == (x :: Int) 
     
