module Main (main) where
import Pred
import Dibujo
import Test.Hspec

main :: IO ()
main = hspec $ do
    describe "cambiar" $ do 
        it "Dado un predicado sobre básicas, cambiar todas las que satisfacen" $ do
            let p :: String -> Bool
                p x = length x < 10
                fun :: String -> Dibujo String
                fun x = figura "menos_de_10"
                dib = apilar 1 1 (figura "corto") (figura "muy_largo")
                r = apilar 1 1 (figura "menos_de_10") (figura "menos_de_10")
            (cambiar p fun dib) `shouldBe` r


    describe "anyDib" $ do 
        it "Alguna básica satisface el predicado" $ do
            let p :: String -> Bool
                p x = length x < 5
                dib = apilar 1 1 (figura "corto") (figura "muy_largo")
            (anyDib p dib) `shouldBe` (2 < 1)

    describe "allDib" $ do 
        it "Todas las básicas satisfacen el predicado" $ do
            let p :: String -> Bool
                p x = length x < 5
                dib = apilar 1 1 (figura "corto") (figura "muy_largo")
            (allDib p dib) `shouldBe` (2 < 1)

    describe "andP" $ do 
        it "Los dos predicados se cumplen para el elemento recibido" $ do
            let p1 :: String -> Bool
                p1 x = length x < 10
                p2 :: String -> Bool
                p2 x = 1 < length x
                p = andP p1 p2
                ss = "corto"
            p ss `shouldBe` (1 < 2)

    describe "orP" $ do 
        it "Algún predicado se cumple para el elemento recibido" $ do
            let p1 :: String -> Bool
                p1 x = length x < 3
                p2 :: String -> Bool
                p2 x = 1 < length x
                p = orP p1 p2
                ss = "corto"
            p ss `shouldBe` (1 < 2)                   