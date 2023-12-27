module Squizz.Types
  ( -- * Types
    RGB (..),
    Raster (..),
    Point2D (..),
  )
where

import Data.Word (Word16)

-- | 2D point.
data Point2D a = Point2D
  { x :: !a,
    y :: !a
  }
  deriving (Functor)

-- | RGB color.
data RGB a = RGB
  { red :: !a,
    green :: !a,
    blue :: !a
  }

-- | Raster with a list as the underlying container type.
data Raster f a = Raster
  { width :: !Word16,
    height :: !Word16,
    pixels :: f (RGB a)
  }
