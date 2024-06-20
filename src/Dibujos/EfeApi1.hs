module Dibujos.EfeApi1 where

import Dibujo (Dibujo, figura, juntar, apilar, rot45, rotar, encimar, espejar)
import FloatingPic(Conf(..), Output, half, zero)
import qualified Graphics.Gloss.Data.Point.Arithmetic as V
import Graphics.Gloss ( Picture, blue, red, color, line, pictures )

-- Les ponemos colorcitos para que no sea _tan_ feo
data Color = Azul | Rojo
    deriving (Show, Eq)

data BasicaSinColor = Rectangulo | Cruz | Triangulo | Efe
    deriving (Show, Eq)

type Basica = (BasicaSinColor, Color)

colorear :: Color -> Picture -> Picture
colorear Azul = color blue
colorear Rojo = color red




interpBasicaSinColor :: Output BasicaSinColor
interpBasicaSinColor Efe x y w = line . map (x V.+) $ [
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


efeMake:: Dibujo Basica
efeMake = apilar 0.5 0.5 (figura (Efe,Azul)) (figura (Efe,Rojo)) 

interpBas :: Output Basica
interpBas (b, c) x y w = colorear c $ interpBasicaSinColor b x y w





efeApi1 :: Conf
efeApi1 = Conf {
    name = "EfeApi"
    , pic = efeMake
    , bas = interpBas
}



--apilar 1 1 fogira 0 Rptarfiguta 2
--Con Pattern Matching
ProfDib:: Dibujo a -> Int
profDib (Figura x) = 1
profDib (Rotar dib) = (profDib dib) +1
profDib (Rot45 dib) = (profDib dib) +1
profDib (Espejar dib) = (profDib dib) +1
profDib (Apilar x y dib1 dib2) = max ((profDib dib1),(profDib dib2)) + 1
profDib (Juntar x y dib1 dib2) = max ((profDib dib1),(profDib dib2)) +1
profDib (Encimar x y dib1 dib2) = max((profDib dib1)(profDib dib2)) +1

--Apilar (x y r(e(r(e(r(fig1))))) e(r45(r(fig2)))) = 

-- x(5)        y(3)

--Sin Pattern Matching
proFoldDib:: Dibujo a -> Int
proFoldDib = foldDib (\x -> + 1) (\dib -> dib + 1) (\dib -> dib + 1) (\dib ->dib + 1) (\x y dib1 dib2 -> max(dib1,dib2) +1 ) 
                     (\x y dib1 dib2 -> max (dib1,dib2) +1) (\dib1 dib2 -> max(dib1 dib2) +1)
