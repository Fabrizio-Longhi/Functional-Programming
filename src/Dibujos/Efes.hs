module Dibujos.Efes where

import Dibujo (Dibujo, figura, juntar, apilar, rot45, rotar, encimar, espejar, r270, encimar4, cuarteto, r180)
import FloatingPic(Conf(..), Output, half, zero)
import qualified Graphics.Gloss.Data.Point.Arithmetic as V
import Graphics.Gloss ( Picture, blue, red, color, line, translate, scale, pictures, text, blank, polygon)
import Dibujos.Escher

type Escher = Bool

interpEfes :: Output Escher
interpEfes False a b c = blank
interpEfes True x y w = line . map (x V.+) $ [
        zero,uX, p13, p33, p33 V.+ uY , p13 V.+ uY,
        uX V.+ 4 V.* uY ,uX V.+ 5 V.* uY, x4 V.+ y5,
        x4 V.+ 6 V.* uY, 6 V.* uY, zero
    ]
    where
        p33 = 3 V.* (uX V.+ uY)
        p13 = uX V.+ 3 V.* uY
        x4 = 4 V.* uX
        y5 = 5 V.* uY
        uX = (1/6) V.* y
        uY = (1/6) V.* w

dib = escher 7 True

efesConfig :: Conf
efesConfig = Conf {
    name = "Efes"
    , pic = dib
    , bas = interpEfes
}
