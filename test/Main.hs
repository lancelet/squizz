module Main (main) where

import System.IO (hFlush, stdout)
import TastyDriver qualified
import Test.DocTest (doctest)

main :: IO ()
main = do
  runDocTests
  runTastyTests

printBanner :: String -> IO ()
printBanner banner = do
  hFlush stdout
  putStr "\ESC[0;32m--- "
  putStr banner
  putStr " ---\ESC[0m\n"
  hFlush stdout

runTastyTests :: IO ()
runTastyTests = do
  printBanner "Tasty Tests"
  TastyDriver.main

runDocTests :: IO ()
runDocTests = do
  printBanner "Doc Tests"
  doctest ["-isrc", "src"]
