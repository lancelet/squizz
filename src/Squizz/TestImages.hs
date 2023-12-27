module Squizz.TestImages
  ( checkerBoard,
  )
where

import Data.Fixed (mod')
import Squizz.Types (Point2D (Point2D))

checkerBoard ::
  forall a b.
  (RealFrac a) =>
  -- | Color 1 in the checkerboard.
  b ->
  -- | Color 2 in the checkerboard.
  b ->
  -- | Width of squares in the checkerboard.
  a ->
  -- | Height of squares in the checkerboard.
  a ->
  -- | Checkerboard image.
  (Point2D a -> b)
checkerBoard color1 color2 width height (Point2D x y) =
  let w2, h2, xf, yf :: a
      w2 = 2 * width
      h2 = 2 * height
      xf = mod' x w2 / w2
      yf = mod' y h2 / h2
   in if (xf < 0.5 && yf < 0.5) || (xf >= 0.5 && yf >= 0.5)
        then color1
        else color2
