{-# LANGUAGE OverloadedRecordDot #-}

module Squizz.PPM
  ( -- * Functions
    writeRasterPPM,
  )
where

import Control.Exception (bracket)
import Data.Word (Word8)
import Foreign (withArrayLen)
import Squizz.Types (RGB (RGB), Raster (height, pixels, width))
import System.IO
  ( Handle,
    IOMode (WriteMode),
    hClose,
    hPutBuf,
    hPutStrLn,
    openFile,
  )

writeRasterPPM ::
  FilePath ->
  Raster [] Word8 ->
  IO ()
writeRasterPPM out_file raster = bracket open hClose action
  where
    open :: IO Handle
    open = openFile out_file WriteMode

    bytes :: [Word8]
    bytes = concatMap (\(RGB r g b) -> [r, g, b]) raster.pixels

    action :: Handle -> IO ()
    action h = do
      hPutStrLn h "P6"
      hPutStrLn h $ show raster.width <> " " <> show raster.height
      hPutStrLn h "255"
      withArrayLen bytes $ \len ptr ->
        hPutBuf h ptr len
