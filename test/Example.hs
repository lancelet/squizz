module Example where

import Test.Hspec (Spec, describe, it, pending, shouldBe)

spec_example :: Spec
spec_example = do
  describe "list" $ do
    it "should reverse twice" $ do
      let x = [1, 2, 3]
      reverse (reverse x) `shouldBe` x
