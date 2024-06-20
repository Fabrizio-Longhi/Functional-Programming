module Dibujos.Grilla (
    grilla,
    grillaConf
) where

import Dibujo (Dibujo, figura, juntar, apilar, rot45, rotar, encimar, espejar)
import FloatingPic(Conf(..), Output, half, zero)
import qualified Graphics.Gloss.Data.Point.Arithmetic as V
import Graphics.Gloss ( Picture, blue, red, color, line, translate, scale, pictures, text )

row :: [Dibujo a] -> Dibujo a
row [] = error "row: no puede ser vacío"
row [d] = d
row (d:ds) = juntar 1 (fromIntegral $ length ds) d (row ds)

column :: [Dibujo a] -> Dibujo a
column [] = error "column: no puede ser vacío"
column [d] = d
column (d:ds) = apilar 1 (fromIntegral $ length ds) d (column ds)

grilla :: [[Dibujo a]] -> Dibujo a
grilla = column . map row

type Basica = (Int, Int)


interpBas :: Output Basica
interpBas (x,y) (a,b) _ _ =  translate (a+10) (b+10) (scale 0.15 0.15 (text ("(" ++ show x ++ ", " ++ show y ++ ")")))




dibGrilla :: Int -> [[Dibujo Basica]]
dibGrilla n = [get x | x <- [0..n]]
    where
        get x = [obj x y | y <- [0..n]]
        obj x y = figura (x,y)
        

dib :: Dibujo Basica
dib = grilla $ dibGrilla 7

grillaConf :: Conf
grillaConf = Conf {
    name = "Grilla"
    , pic = dib
    , bas = interpBas
}

