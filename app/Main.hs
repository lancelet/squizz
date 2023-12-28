{-# LANGUAGE DuplicateRecordFields #-}

module Main (main) where

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
    RingMoireConfig
      ( RingMoireConfig,
        center,
        color1,
        color2,
        colorbg,
        edgeWidth,
        nSegments,
        radius
      ),
    checkerBoard,
    ringMoire,
  )
import Squizz.Types (Point2D (Point2D), RGB (RGB))

main :: IO ()
main =
  let cfg_cb :: CheckerBoardConfig Float (RGB Word8)
      cfg_cb =
        CheckerBoardConfig
          { color1 = RGB 255 255 255,
            color2 = RGB 0 0 0,
            rectWidth = 16,
            rectHeight = 16
          }

      cb :: Point2D Word16 -> RGB Word8
      cb = checkerBoard cfg_cb . fmap fromIntegral

      cfg_rm :: RingMoireConfig Float (RGB Word8)
      cfg_rm =
        RingMoireConfig
          { center = Point2D 128 128,
            radius = 120,
            color1 = RGB 0 0 0,
            color2 = RGB 255 255 255,
            colorbg = RGB 255 255 255,
            nSegments = 256,
            edgeWidth = 0.01
          }

      rm :: Point2D Word16 -> RGB Word8
      rm = ringMoire cfg_rm . fmap fromIntegral
   in do
        writeRasterPPM "checkerboard.ppm" $ rasterizeSimple 128 64 cb
        writeRasterPPM "ringmoire.ppm" $ rasterizeSimple 256 256 rm
