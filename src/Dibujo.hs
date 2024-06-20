{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Eta reduce" #-}
module Dibujo (Dibujo, encimar, figura, apilar,juntar,rotar,espejar,
              rot45, r90,r180,r270,
              (^^^), (.-.), (///),
              encimar4,ciclar,cuarteto,
              foldDib, mapDib, change
    -- agregar las funciones constructoras
    ) where


-- nuestro lenguaje   Rotar (Rotar (Figura a))
--data Dibujo  = Dibujo

data Dibujo a = Figura a 
              | Rotar (Dibujo a)
              | Espejar (Dibujo a)
              | Rot45 (Dibujo a)
              | Apilar Float Float (Dibujo a) (Dibujo a)  -- Rotar(Espejar(Apilar(figura a)))
              | Juntar Float Float (Dibujo a) (Dibujo a)  
              | Encimar (Dibujo a) (Dibujo a)
              deriving (Eq,Show)

-- combinadores
infixr 6 ^^^  

infixr 7 .-.

infixr 8 ///

comp :: Int -> (a -> a) -> a -> a
comp n f x
        | n > 0 = comp (n-1) f (f x)
        | n == 0 = x
        | otherwise = error "comp solo toma valores positivos"


-- Funciones constructoras
figura :: a -> Dibujo a
figura a = Figura a

encimar :: Dibujo a -> Dibujo a -> Dibujo a
encimar x y = Encimar x y

apilar :: Float -> Float -> Dibujo a -> Dibujo a -> Dibujo a
apilar f g x y = Apilar f g x y

juntar  :: Float -> Float -> Dibujo a -> Dibujo a -> Dibujo a
juntar f g x y = Juntar f g x y

rot45 :: Dibujo a -> Dibujo a
rot45 x = Rotar x 

rotar :: Dibujo a -> Dibujo a
rotar x = Rotar x


espejar :: Dibujo a -> Dibujo a
espejar x = Espejar x

-----------------------------------------------------------------------------------------------------


(^^^) :: Dibujo a -> Dibujo a -> Dibujo a 
(^^^) x y = encimar x y

(.-.) :: Dibujo a -> Dibujo a -> Dibujo a
(.-.) x y = apilar 0.5 0.5 x y

(///) :: Dibujo a -> Dibujo a -> Dibujo a
(///) x y = juntar 0.5 0.5 x y

----------------------------------------------------------------------------------------------------
-- rotaciones
r90 :: Dibujo a -> Dibujo a
r90 x = rotar x

r180 :: Dibujo a -> Dibujo a
r180 x = comp 2 r90 x

r270 :: Dibujo a -> Dibujo a
r270 x = comp 3 r90 x



----------------------------------------------------------------------------------------------------

-- una figura repetida con las cuatro rotaciones, superimpuestas.
encimar4 :: Dibujo a -> Dibujo a
encimar4 x = x ^^^ (r90 x ^^^ (r180 x ^^^ r270 x))

-- cuatro figuras en un cuadrante.
cuarteto :: Dibujo a -> Dibujo a -> Dibujo a -> Dibujo a -> Dibujo a
cuarteto  x y z w = (.-.) ((///) x y) ((///) z w )

-- un cuarteto donde se repite la imagen, rotada (¡No confundir con encimar4!)
ciclar :: Dibujo a -> Dibujo a
ciclar x = cuarteto x (r90 x) (r180 x) (r270 x)

-- map para nuestro lenguaje
mapDib :: (a -> b) -> Dibujo a -> Dibujo b
mapDib f (Figura x) = figura (f x)
mapDib f (Rotar d) = rotar (mapDib f d)
mapDib f (Espejar d) = espejar (mapDib f d)
mapDib f (Rot45 d) = rot45 (mapDib f d)
mapDib f (Apilar f1 f2 d1 d2) = apilar f1 f2 (mapDib f d1) (mapDib f d2)  
mapDib f (Juntar f1 f2 d1 d2) = juntar f1 f2 (mapDib f d1) (mapDib f d2)
mapDib f (Encimar d1 d2) = encimar (mapDib f d1) (mapDib f d2)
-- verificar que las operaciones satisfagan
-- 1. map figura = id
-- 2. map (g . f) = mapDib g . mapDib f



-- Cambiar todas las básicas de acuerdo a la función.
change :: (a -> Dibujo b) -> Dibujo a -> Dibujo b
change f (Figura x) =  f x 
change f (Rotar d) = rotar (change f d)
change f (Espejar d) = espejar (change f d)
change f (Rot45 d) = rot45 (change f d)
change f (Apilar f1 f2 d1 d2) = apilar f1 f2 (change f d1) (change f d2)
change f (Juntar f1 f2 d1 d2) = juntar f1 f2 (change f d1) (change f d2)
change f (Encimar d1 d2) = encimar (change f d1) (change f d2)

-- Principio de recursión para Dibujos.
foldDib ::
  (a -> b) ->
  (b -> b) ->
  (b -> b) ->
  (b -> b) ->
  (Float -> Float -> b -> b -> b) ->
  (Float -> Float -> b -> b -> b) ->
  (b -> b -> b) ->
  Dibujo a ->
  b

foldDib fBasica fRotar fEspejar fRot45 fApilar fJuntar fEncimar dibujo = case dibujo of
    Figura a -> fBasica a
    Rotar d -> fRotar (foldDib fBasica fRotar fEspejar fRot45 fApilar fJuntar fEncimar d)
    Espejar d -> fEspejar (foldDib fBasica fRotar fEspejar fRot45 fApilar fJuntar fEncimar d)
    Rot45 d -> fRot45 (foldDib fBasica fRotar fEspejar fRot45 fApilar fJuntar fEncimar d)
    Apilar x y d1 d2 -> fApilar x y (foldDib fBasica fRotar fEspejar fRot45 fApilar fJuntar fEncimar d1) (foldDib fBasica fRotar fEspejar fRot45 fApilar fJuntar fEncimar d2)
    Juntar x y d1 d2 -> fJuntar x y (foldDib fBasica fRotar fEspejar fRot45 fApilar fJuntar fEncimar d1) (foldDib fBasica fRotar fEspejar fRot45 fApilar fJuntar fEncimar d2)
    Encimar d1 d2 -> fEncimar (foldDib fBasica fRotar fEspejar fRot45 fApilar fJuntar fEncimar d1) (foldDib fBasica fRotar fEspejar fRot45 fApilar fJuntar fEncimar d2)

