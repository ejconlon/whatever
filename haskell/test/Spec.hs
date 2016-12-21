{-# LANGUAGE OverloadedStrings    #-}
{-# LANGUAGE QuasiQuotes          #-}

import qualified Whatever as W
import           Control.Monad.Catch
import qualified Data.Map.Strict          as M
import           Data.Map.Strict          (Map)
import qualified Data.Set                 as S
import           Data.Set                 (Set)
import           Data.Monoid              ((<>))
import           Data.Text                (Text)
import qualified Data.Text                as T
import           Data.Vector              (Vector)
import qualified Data.Vector              as V
import qualified Test.QuickCheck.Property as P
import           Test.Tasty
import           Test.Tasty.HUnit
import           Test.Tasty.QuickCheck
import           Text.Heredoc             (here)

-- Tests

testSomething :: TestTree
testSomething = testCase "something" $ do
  1 @?= 1

-- Runner

tests :: TestTree
tests = testGroup "Tests"
  [ testSomething
  ]

main :: IO ()
main = defaultMain tests

-- Example heredoc

example :: Text
example = T.pack [here|
hello, quasiquotes
|]

-- Boilerplate

propertyIO :: Assertion -> Property
propertyIO action = ioProperty tester
  where
    tester :: IO P.Result
    tester = catch (action >> return P.succeeded) handler
    handler (HUnitFailure err) = return P.failed { P.reason = err }

testPropertyIO :: TestName -> Gen a -> (a -> Assertion) -> TestTree
testPropertyIO name g t = testProperty name (propertyIO . t <$> g)
