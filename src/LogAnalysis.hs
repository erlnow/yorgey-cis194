{-# OPTIONS_GHC -Wall #-}
-- |
-- Module      :  LogAnalysis
-- Description :  CIS 194: Homework 2
-- Copyright   :  erlnow 2020 - 2030
-- License     :  BSD3
--
-- Maintainer  :  erlestau@gmail.com
-- Stability   :  experimental
-- Portability :  unknown
--
-- Yorgey's CIS 194: Introduction to Haskell (Spring 2013)

module LogAnalysis where

import Log

-- * Log file parsing
--
-- **Exercise 1
--
-- $ex1
--
-- The first step is figuring out how to parse an individual message. Define a
-- function:
-- 
-- @
--   parseMessage :: String -> LogMessage
-- @
--
-- which parse an individual line from the log file. For example:
--
-- @
--   parseMessage "I 29 la la la" == LogMessage Info 29 "la la la"
--
--   parseMessage "This is not in the right format" == Unknow "This is not in the right format"
-- @
--
-- Once we can parse one log message, we can parse a whole log file.
-- Define a function
--
-- @
--   parse :: String -> [LogMessage]
-- @
--
-- which parse an entire log file at once and returns its contents as a list of
-- 'LogMessages'.
--
-- To test your function, use the 'testParse' function provided in the 'Log'
-- module, giving it as arguments your 'parse' function, the number of lines to
-- parse, and the log file to parse from (which should also be in the same
-- folder as your assignment). For example, after loading your assignment
-- into @GHCi@, type something like this at the prompt:
--
-- @
--   testParse parse 10 "error.log"
-- @
--
-- Don't reinvent the wheel! (That's so /last/ week.) Use 'Prelude' functions
-- to make your solution as concise, high-level, and functional as possible.
-- For example, to convert a 'String' like @"562"@ into an 'Int', you can 
-- use the 'read' function. Other functions which may (or may not) be useful
-- to you include 'lines', 'words', 'unwords', 'take', 'drop' and '(.)'

-- |parse a 'String' and returns a value of type 'LogMessage'
--
-- First version: assume that all logs are well formed
parseMessage :: String -> LogMessage
parseMessage [] = Unknown ""
parseMessage xs = case hl of
                    "I" -> if getTime == Nothing
                              then Unknown xs
                              else LogMessage Info (j getTime) getMsg 
                    "W" -> if getTime == Nothing
                              then Unknown xs
                              else LogMessage Warning (j getTime) getMsg
                    "E" -> if getError == Nothing || getTime == Nothing
                              then Unknown xs
                              else LogMessage (Error (j getError)) (j getTime) getMsg
                    _   -> Unknown (xs)
                where
                  j (Just a) = a
                  line = words xs       -- has at last one word
                  hl = head line
                  msgError = head. tail $ line
                  msgTime  = if hl == "E"
                                then head . tail . tail $ line
                                else head . tail $ line 
                  getError = if null msgError
                                then Nothing
                                else Just (read msgError :: Int)
                  getTime  = if null msgTime
                                then Nothing
                                else Just (read msgTime :: Int)
                  getMsg   = if hl == "E"       -- can be "" 
                                then unwords . tail . tail . tail $ line
                                else unwords . tail . tail $ line 

-- |parse a full log file and returns its contents as a list of 'LogMessage's.
parse :: String -> [LogMessage]
parse [] = []
parse xs = map parseMessage (lines xs)
