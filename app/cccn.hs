{-# LANGUAGE OverloadedStrings #-}
module Main where

import qualified Cards (validate)

main :: IO ()
main = do
  -- TODO: Read credit card numbers from stdio or a file
  --       parse args
  --       when I will know how to do it
  let cn1 = 5489019153422406
      cn2 = 4012888888881881
      cn3 = 4012888888881882 
      line n = (show n) ++ ": " ++ show (Cards.validate n)
  putStrLn (line cn1)
  putStrLn (line cn2)
  putStrLn (line cn3)
