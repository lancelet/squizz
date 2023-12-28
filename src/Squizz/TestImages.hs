{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedRecordDot #-}

module Squizz.TestImages
  ( -- * Types
    CheckerBoardConfig (..),
    RingMoireConfig (..),

    -- * Functions
    checkerBoard,
    ringMoire,
  )
where

import Data.Fixed (mod')
import Data.Word (Word32)
import Squizz.Types (Point2D (Point2D, x, y))

data CheckerBoardConfig a color = CheckerBoardConfig
  { color1 :: color,
    color2 :: color,
    rectWidth :: a,
    rectHeight :: a
  }

checkerBoard ::
  forall a color.
  (RealFrac a) =>
  -- | Configuration of the checkerboard.
  CheckerBoardConfig a color ->
  -- | Checkerboard image.
  (Point2D a -> color)
checkerBoard cfg (Point2D x y) =
  let w2, h2, xf, yf :: a
      w2 = 2 * cfg.rectWidth
      h2 = 2 * cfg.rectHeight
      xf = mod' x w2 / w2
      yf = mod' y h2 / h2
   in if (xf < 0.5 && yf < 0.5) || (xf >= 0.5 && yf >= 0.5)
        then cfg.color1
        else cfg.color2

data RingMoireConfig a color = RingMoireConfig
  { center :: Point2D a,
    radius :: a,
    color1 :: color,
    color2 :: color,
    colorbg :: color,
    nSegments :: Word32,
    edgeWidth :: a
  }

ringMoire ::
  forall a color.
  (RealFloat a) =>
  RingMoireConfig a color ->
  (Point2D a -> color)
ringMoire cfg (Point2D x' y') =
  let x, y :: a
      x = x' - cfg.center.x
      y = y' - cfg.center.y

      r, theta :: a
      r = sqrt (x * x + y * y)
      theta = atan2 y x

      sf, rf, tf :: a
      sf = 2 * pi / fromIntegral cfg.nSegments
      rf = r / cfg.radius
      tf = mod' theta sf / sf
   in if rf > 1
        then cfg.colorbg
        else
          if (rf > 1 - cfg.edgeWidth) || (tf > 0.5)
            then cfg.color1
            else cfg.color2
