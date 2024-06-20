module Interp
  ( interp,
    initial,
    ov,
    r45,
    rot,
    esp,
    sup,
    jun,
    api,
  )
where

import Dibujo
import FloatingPic ( Conf(Conf), Output, FloatingPic, grid, half )
import Graphics.Gloss (Display (InWindow), color, display, makeColorI, pictures, translate, white, Picture (Pictures))
-- import qualified GHC.Real as R
import qualified Graphics.Gloss.Data.Point.Arithmetic as V

-- Dada una computación que construye una configuración, mostramos por
-- pantalla la figura de la misma de acuerdo a la interpretación para
-- las figuras básicas. Permitimos una computación para poder leer
-- archivos, tomar argumentos, etc.
initial :: Conf -> Float -> IO ()
initial (Conf n dib intBas) size = display win white $ withGrid fig size
  where
    win = InWindow n (ceiling size, ceiling size) (0, 0)
    fig = interp intBas dib (0, 0) (size, 0) (0, size)
    desp = -(size / 2)
    withGrid p x = translate desp desp $ pictures [p, color grey $ grid (ceiling $ size / 10) (0, 0) x 10]
    grey = makeColorI 100 100 100 100

-- Interpretación de (^^^)
ov :: Picture -> Picture -> Picture
ov p q = Pictures [p,q]


--- type FloatingPic = Vector -> Vector -> Vector -> Picture
--                      d           w        h

--f(d+(w+h)/2, (w+h)/2, (h-w)/2)
r45 :: FloatingPic -> FloatingPic 
r45 f d w h = f (d V.+ half(w V.+ h)) (half(w V.+ h)) (half(h V.- w))


--f(d+w, h, -w) 
rot :: FloatingPic -> FloatingPic
rot f d w h = f (d V.+ w) h (V.negate w)

--f(d+w, -w, h)
esp :: FloatingPic -> FloatingPic
esp f d w h = f (d V.+ w) (V.negate w)  h


--f(d, w, h) ∪ g(d, w, h)
sup :: FloatingPic -> FloatingPic -> FloatingPic
sup f g d w h = Pictures[f d w h, g d w h]

--f(x, w', h) ∪ g(d+w', r'*w, h) con r'=n/(m+n), r=m/(m+n), w'=r*w
jun :: Float -> Float -> FloatingPic -> FloatingPic -> FloatingPic
jun fl1 fl2 f g d w h = Pictures[f d w' h, g (d V.+ w') (r' V.* w) h]
 where r = fl1/(fl1+fl2)
       w' = r V.* w
       r' = fl2/(fl1+fl2)

--f(d + h', w, r*h) ∪ g(d, w, h') con r' = n/(m+n), r=m/(m+n), h'=r'*h
api :: Float -> Float -> FloatingPic -> FloatingPic -> FloatingPic
api fl1 fl2 f g d w h = Pictures[f (d V.+ h') w (r V.* h), g d w h']
  where r' = fl2 / (fl1 + fl2) 
        r = fl1 / (fl1 + fl2)
        h'= r' V.* h


-- type Output a = a -> FloatingPic


-- Output a -> Output (Dibujo a) ==  (a -> FloatingPic) -> (Dibujo a -> FloatingPic)

interp :: Output a -> Output (Dibujo a)
interp interFig = foldDib interFig rot esp r45 api jun sup
