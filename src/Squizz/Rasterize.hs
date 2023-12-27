module Squizz.Rasterize
  ( rasterizeSimple,
  )
where

import Data.Word (Word16, Word8)
import Squizz.Types (Point2D (Point2D), RGB, Raster (Raster))

rasterizeSimple ::
  Word16 ->
  Word16 ->
  (Point2D Word16 -> RGB Word8) ->
  Raster [] Word8
rasterizeSimple width height image = Raster width height pixels
  where
    pixels :: [RGB Word8]
    pixels =
      [ image (Point2D i j)
        | j <- [0 .. height - 1],
          i <- [0 .. width - 1]
      ]
