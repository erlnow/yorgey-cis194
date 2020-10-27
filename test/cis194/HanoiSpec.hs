-- |
-- Module      :  HanoiSpec
-- Copyright   :  erlnow 2020 - 2030
-- License     :  BSD3
--
-- Maintainer  :  erlestau@gmail.com
-- Stability   :  experimental
-- Portability :  unknown
--
-- Test and use case of functions in 'Hanoi' module
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

module HanoiSpec (spec) where

import qualified Hanoi
import Test.Hspec
-- import Test.QuickCheck

spec :: Spec
spec = do
  describe "Towers of Hanoi" $ do
    it "hanoi 2 \"a\" \"b\" \"c\"" $ do
      Hanoi.hanoi 2 "a" "b" "c" `shouldBe` [("a","c"), ("a","b"), ("c","b")]
    -- TODO: Can i make a generator? After 24 hours only 39/100 tests
    -- it "number of move" $ property $
    --  \n -> if n > 0 then length (Hanoi.hanoi n "a" "b" "c") == (2^n) - 1
    --                 else True
    it "End of the world" $ do
      let n :: Int
          n = 15
       in length (Hanoi.hanoi (fromIntegral n) "a" "b" "c") `shouldBe` (2^n) - 1
    it "reve 15" $ do
      -- let n :: Int
      --     n = 15
      --     result = length (Hanoi.reeve (fromIntegral n) "a" "b" "c" "d")
      --  in result >= 120 && result <= (2^n)-1 `shouldBe` True 
      pendingWith "Implement"
