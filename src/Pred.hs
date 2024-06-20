{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Eta reduce" #-}
module Pred (
  Pred,
  cambiar, anyDib, allDib, orP, andP, falla
) where

import Dibujo

type Pred a = a -> Bool 

-- Dado un predicado sobre básicas, cambiar todas las que satisfacen        
-- el predicado por la figura básica indicada por el segundo argumento.
cambiar:: Pred a -> (a -> Dibujo a) -> Dibujo a -> Dibujo a
cambiar pr fun dibujo = change f' dibujo
  where f' a
           | pr a = fun a
           | otherwise = figura a


-- Alguna básica satisface el predicado.
anyDib :: Pred a -> Dibujo a -> Bool
anyDib pre dibujo = foldDib pre id id id orr orr orrSinFloat dibujo
  where
    orr _ _ d1 d2 = d1 || d2
    orrSinFloat d1 d2 = d1 || d2



-- Todas las básicas satisfacen el predicado.
allDib :: Pred a -> Dibujo a -> Bool
allDib pre dibujo = foldDib pre id id id andd andd anddSinFloat dibujo
  where
    andd _ _ d1 d2 = d1 && d2
    anddSinFloat d1 d2 = d1 && d2

-- Los dos predicados se cumplen para el elemento recibido.
andP :: Pred a -> Pred a -> Pred a
andP p1 p2 = fun 
  where fun a = p1 a && p2 a


-- Algún predicado se cumple para el elemento recibido.
orP :: Pred a -> Pred a -> Pred a
orP p1 p2 = fun
  where fun a = p1 a || p2 a

falla = True