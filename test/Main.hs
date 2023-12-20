module Main (main) where

import qualified TastyDriver
import Test.DocTest (doctest)

main :: IO ()
main = do
  runDocTests
  -- runTastyTests

printBanner :: String -> IO ()
printBanner = putStrLn

runTastyTests :: IO ()
runTastyTests = do
  printBanner "Tasty Tests"
  TastyDriver.main

runDocTests :: IO ()
runDocTests = do
  printBanner "DocTests"
  doctest ["-isrc", "src"]