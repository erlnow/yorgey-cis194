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

spec :: Spec
spec = do
  describe "Intro" $ do
    -- TODO: QuickSpec Better
    it "sumtorial 1000" $ do
      sumtorial 1000 `shouldBe` 1000 * (1000 + 1) `div` 2



