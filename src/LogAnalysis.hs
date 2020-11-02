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
-- 'LogMessage's.
--
-- To test your function, use the 'testParse' function provided in the "Log"
-- module, giving it as arguments your 'parse' function, the number of lines to
-- parse, and the log file to parse from (which should also be in the same
-- folder as your assignment). For example, after loading your assignment
-- into @GHCi@, type something like this at the prompt:
--
-- @
--   testParse parse 10 "error.log"
-- @
--
-- Don't reinvent the wheel! (That's so /last/ week.) Use "Prelude" functions
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

-- *Putting the logs in order
--
-- **Exercise 2
--
-- $ex2
--
-- Define a function
--
-- @
--   insert :: LogMessage -> MessageTree -> MessageTree
-- @
--
-- which insert a new 'LogMessage' into an existing 'MessageTree', producing a
-- new 'MessageTree'. 'insert' may assume that it is given a sorted
-- 'MessageTree', and must produce a new sorted 'MessageTree' containing the
-- new 'LogMessage' in addition to the contents of the original 'MessageTree'.
--
-- However, note that if 'insert' is given a 'LogMessage' which is 'Unknown',
-- it should return the 'MessageTree' unchanged.

-- |insert a 'LogMessage' in a sorted 'MessageTree' and return a new sorted
-- 'MessageTree'. If 'LogMessage' is 'Unknown' return the 'MessageTree'
-- unchanged.
insert :: LogMessage -> MessageTree -> MessageTree
insert (Unknown _) mt = mt
insert lm (Leaf)   = Node Leaf lm Leaf
insert l@(LogMessage _ t _) (Node i l'@(LogMessage _ t' _) d)
  = if t < t' then Node (insert l i) l' d
              else Node i l' (insert l d)

-- **Exercise 3
--
-- $ex3
--
-- Once we can insert a single 'LogMessage' into a 'MessageTree', we can build
-- a complete 'MessageTree' from a list of messages. Specifically, define a
-- function
--
-- @
--   build :: [LogMessages] -> MessageTree
-- @
--
-- which builds up a MessageTree containing the messages in the list, be
-- successively inserting the messages into a 'MessageTree' (beginning with a
-- 'Leaf')

-- |from a given list of 'LogMessage's builds up a sorted tree of 'LogMessages'
build :: [LogMessage] -> MessageTree
build = foldr insert Leaf 

-- **Exercise 4
--
-- $ex4
--
-- Finally, define the function
--
-- @
--   inOrder :: MessageTree -> [LogMessage]
-- @
--
-- which takes a sorted 'MessageTree' and produces a list of all the
-- 'LogMessages' it contains, sorted by time stamp from smallest to biggest.
-- (This is known as /in-order traversal/ of the MessageTree.)
--
-- With these functions, we can now remove 'Unknown' messages and sort the
-- well-formed messages using an expression such as:
--
-- @
--   inOrder (build tree)
-- @
--
-- [Note: there are much better ways to sort a list; this is just an exercise
-- to get you working with recursive data structures!]

inOrder :: MessageTree -> [LogMessage]
inOrder Leaf = []
inOrder (Node i l d) = inOrder i ++ [l] ++ inOrder d

-- *Log file postmortem
--
-- ** Exercise 5
--
-- $ex5
--
-- Now that we can sort the log messages, the only thing left to do is extract
-- the relevant information. We have decided that \"relevant\" means \"errors
-- with a severity of at least 50\".
--
-- Write a function
--
-- @
--   whatWentWrong :: [LogMessage] -> [String]
-- @
--
-- which take an /unsorted/ list of LogMessages, and return a list of the
-- messages corresponding to any errors with a severity of 50 or greater,
-- sorted by timestamp. (Of course, you can use your functions from the
-- previous exercises to do the sorting.)
--
-- For example, suppose our log file looked like this:
--
-- @
--   I 6 Completed armadillo processing
--   I 1 Nothing to report
--   E 99 10 Flange failed!
--   I 4 Everything normal
--   I 11 Initiating self-destruct sequence
--   E 70 3 Way too many pickles
--   E 65 8 Bad pickle-flange interaction detected
--   W 5 Flange is due for a check-up
--   I 7 Out for lunch, back in two time steps
--   E 20 2 Too many pickles
--   I 9 Back from lunch
-- @
--
-- This file is provided as @sample.log@. There are four errors, three of which
-- have a severity of greater than 50. The output of 'whatWentWrong' on
-- @sample.log@ ought to be
--
-- @
--   [ "Way too many pickles"
--   , "Bad pickle-flange interaction detected"
--   , "Flange failed!"
--   ]
-- @
--
-- You can test your 'whatWentWrong' function with 'testWhatWentWrong', which
-- is also provided by the "Log" module. You should provide 'testWhatWentWrong'
-- with your parse function, your 'whatWentWrong' function, and the name of the
-- log file to parse.

-- |a function that takes an unsorted list of LogMessage items and return a
-- list of string from the LogMessages sorted by timestamp that are Errors with
-- a severity greater than 50.
whatWentWrong :: [LogMessage] -> [String]
whatWentWrong = map getMsg . filter meaningLog . inOrder . build

meaningLog :: LogMessage -> Bool 
meaningLog (LogMessage (Error s) _ _) = s > 50 
meaningLog _ = False

getMsg :: LogMessage -> String
getMsg (Unknown s)        = s
getMsg (LogMessage _ _ s) = s

-- *Miscellaneous
--
-- $misc
--
-- * We will test your solution on log files other than the ones we have given
-- you, so no hardcoding!
--
-- * You are free (in fact, encouraged) to discuss the assignment with any of
-- your classmates as long as you type up your own solution.

-- *Epilogue
--
-- **Exercise 6
--
-- $ex6
--
-- For various reasons we are beginning to suspect that the recent mess was
-- caused by a single, egoistical hacker. Can you figure out who did it?)
-- 
whatWentWrong' :: [LogMessage] -> [(TimeStamp,String)]
whatWentWrong' = map getMsg' . filter meaningLog . inOrder . build
  where getMsg' (LogMessage _ t s) = (t,s)

huntHacker :: [LogMessage] -> [String]
huntHacker = map getMsg . filter errors . inOrder . build
  where errors (LogMessage (Error _) t _) = t < 131 
        errors _ = False
