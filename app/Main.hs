module Main where

import Data.Word (Word16, Word8)
import Squizz.PPM (writeRasterPPM)
import Squizz.Rasterize (rasterizeSimple)
import Squizz.TestImages (checkerBoard)
import Squizz.Types (Point2D, RGB (RGB))

main :: IO ()
main =
  let cb :: Point2D Float -> RGB Word8
      cb = checkerBoard (RGB 255 255 255) (RGB 0 0 0) 16 16

      cb' :: Point2D Word16 -> RGB Word8
      cb' = cb . fmap fromIntegral
   in writeRasterPPM "checkerboard.ppm" $ rasterizeSimple 128 64 cb'
