module Dibujos.Escher(
    escher,
    escherConfig
) where

import Dibujo (Dibujo, figura, juntar, apilar, rot45, rotar, encimar, espejar, r270, encimar4, cuarteto, r180)
import FloatingPic(Conf(..), Output, half, zero)
import qualified Graphics.Gloss.Data.Point.Arithmetic as V
import Graphics.Gloss ( Picture, blue, red, color, line, translate, scale, pictures, text, blank, polygon)

-- Supongamos que eligen.
type Escher = Bool

vacio :: Dibujo Escher
vacio = figura False

fig :: Dibujo Escher
fig = figura True

fig1 :: Dibujo Escher
fig1 = espejar (rot45 fig)

fig2 :: Dibujo Escher 
fig2 = r270 fig1


interpEscher :: Output Escher
interpEscher False a b c = blank
interpEscher True x y w = line $ map (x V.+) [(0,0), y V.+ half w, w, (0,0)]


-- El dibujo u.
dibujoU :: Dibujo Escher -> Dibujo Escher
dibujoU p = encimar4 fig1

-- El dibujo t.
dibujoT :: Dibujo Escher -> Dibujo Escher
dibujoT p = encimar fig (encimar fig1 fig2)

-- Esquina con nivel de detalle en base a la figura p.
esquina :: Int -> Dibujo Escher -> Dibujo Escher
esquina n p
         | n == 0 = vacio
         | otherwise = cuarteto (esquina (n-1) p) (lado (n-1) p) (rotar (lado (n-1) p))  (dibujoU p)


-- Lado con nivel de detalle.
lado :: Int -> Dibujo Escher -> Dibujo Escher
lado n p   
      | n == 0 = vacio
      | otherwise = cuarteto (lado (n-1) p) (lado (n-1) p) (rotar (dibujoT p)) (dibujoT p)
      
-- Por suerte no tenemos que poner el tipo!
noneto p q r s t u v w x = apilar 1 2 (juntar 1 2 p (juntar 1 1 q r)) 
                        (apilar 1 1 (juntar 1 2 s (juntar 1 1 t u)) 
                        (juntar 1 2 v (juntar 1 1 w x)))

-- above(1, 2, beside(1, 2, p, beside(1, 1, q, r)), 
-- above(1, 1, beside(1, 2, s, beside(1, 1, t, u)), 
-- beside(1, 2, v, beside(1, 1, w, x))))


escher :: Int -> Escher -> Dibujo Escher
escher _ False = vacio
escher n True  = noneto  esq  lad (r270 esq) (rotar lad) (dibujoU fig) (r270 lad) (rotar esq) (r180 lad) (r180 esq)
        where esq = esquina n (dibujoU fig)
              lad = lado n (dibujoT fig)

-- noneto
--     corner2, 
--     side2, 
--     rot(rot(rot(corner2))),
--     rot(side2),
--     u,
--     rot(rot(rot(side2))),
--     rot(corner2),
--     rot(rot(side2)),
--     rot(rot(corner2)))
dib = escher 7 True
-- corner2 = quartet(corner1,side1,rot(side1),u)
-- side = quartet(side,side,rot(t),t)   

escherConfig :: Conf
escherConfig = Conf {
    name = "Escher"
    , pic = dib
    , bas = interpEscher
}
