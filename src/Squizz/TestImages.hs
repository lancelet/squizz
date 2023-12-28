{-# LANGUAGE OverloadedRecordDot #-}

module Squizz.TestImages
  ( -- * Types
    CheckerBoardConfig (..),

    -- * Functions
    checkerBoard,
  )
where

import Data.Fixed (mod')
import Squizz.Types (Point2D (Point2D))

data CheckerBoardConfig a color = CheckerBoardConfig
  { color1 :: color,
    color2 :: color,
    rectWidth :: a,
    rectHeight :: a
  }

checkerBoard ::
  forall a b.
  (RealFrac a) =>
  -- | Configuration of the checkerboard.
  CheckerBoardConfig a b ->
  -- | Checkerboard image.
  (Point2D a -> b)
checkerBoard cfg (Point2D x y) =
  let w2, h2, xf, yf :: a
      w2 = 2 * cfg.rectWidth
      h2 = 2 * cfg.rectHeight
      xf = mod' x w2 / w2
      yf = mod' y h2 / h2
   in if (xf < 0.5 && yf < 0.5) || (xf >= 0.5 && yf >= 0.5)
        then cfg.color1
        else cfg.color2
