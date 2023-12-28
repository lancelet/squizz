module Main where

import Data.Word (Word16, Word8)
import Squizz.PPM (writeRasterPPM)
import Squizz.Rasterize (rasterizeSimple)
import Squizz.TestImages
  ( CheckerBoardConfig
      ( CheckerBoardConfig,
        color1,
        color2,
        rectHeight,
        rectWidth
      ),
    checkerBoard,
  )
import Squizz.Types (Point2D, RGB (RGB))

main :: IO ()
main =
  let cfg :: CheckerBoardConfig Float (RGB Word8)
      cfg =
        CheckerBoardConfig
          { color1 = RGB 255 255 255,
            color2 = RGB 0 0 0,
            rectWidth = 16,
            rectHeight = 16
          }

      cb :: Point2D Word16 -> RGB Word8
      cb = checkerBoard cfg . fmap fromIntegral
   in writeRasterPPM "checkerboard.ppm" $ rasterizeSimple 128 64 cb
