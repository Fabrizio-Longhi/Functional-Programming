import Test.Hspec

import Dibujo 

main :: IO ()
main = hspec $ do 
    describe "figura" $ do 
        it "Crea una figura" $ do
            let d = figura 5
            figura 5 `shouldBe` d
    

    describe "rotar" $ do 
        it "Rota una figura" $ do
            let d = figura 5
            let r = rotar d
            rotar (figura 5) `shouldBe` r
    

    describe "espejar" $ do
        it "Espeja una figura" $ do
            let d = figura 5
            let e = espejar d
            espejar (figura 5) `shouldBe` e 


    describe "rot45" $ do
        it "Rota 45 grados una figura" $ do
            let d = figura 5
            let r = rot45 d
            rot45 (figura 5) `shouldBe` r
    
    
    describe "apilar" $ do
        it "Apila dos figuras" $ do
            let d1 = figura 5
            let d2 = figura 6
            let a = apilar 1 1 d1 d2
            apilar 1 1 (figura 5) (figura 6) `shouldBe` a

    
    describe "juntar" $ do
        it "Junta dos figuras" $ do
            let d1 = figura 5
            let d2 = figura 6
            let j = juntar 1 1 d1 d2
            juntar 1 1 (figura 5) (figura 6) `shouldBe` j

    describe "encimar" $ do
        it "Encima dos figuras" $ do
            let d1 = figura 5
            let d2 = figura 6
            let e = encimar d1 d2
            encimar (figura 5) (figura 6) `shouldBe` e

    
    describe "r180" $ do
        it "Rota 180 grados una figura" $ do
            let d = figura 5
            let r = r180 d
            r180 (figura 5) `shouldBe` r

    
    describe "r270" $ do
        it "Rota 270 grados una figura" $ do
            let d = figura 5
            let r = r270 d
            r270 (figura 5) `shouldBe` r

    
    describe ".-." $ do
        it "Pone una figura sobre la otra, ambas ocupan el mismo espacio" $ do
            let d1 = figura 5
            let d2 = figura 6
            let a = apilar 0.5 0.5 d1 d2
            (figura 5) .-. (figura 6) `shouldBe` a

    
    describe "///" $ do
        it "Pone una figura al lado de la otra, ambas ocupan el mismo espacio" $ do
            let d1 = figura 5
            let d2 = figura 6
            let j = juntar 0.5 0.5 d1 d2
            (figura 5) /// (figura 6) `shouldBe` j

    
    describe "^^^" $ do
        it "Superpone una figura con otra" $ do
            let d1 = figura 5
            let d2 = figura 6
            let e = encimar d1 d2
            (figura 5) ^^^ (figura 6) `shouldBe` e


    describe "cuarteto" $ do
        it "Dadas cuatro figuras las ubica en los cuatro cuadrantes" $ do
            let d1 = figura 5
            let d2 = figura 6
            let d3 = figura 7
            let d4 = figura 8
            let c = cuarteto d1 d2 d3 d4
            cuarteto (figura 5) (figura 6) (figura 7) (figura 8) `shouldBe` c

    
    describe "encimar4" $ do
        it "Una figura repetida con las cuatro rotaciones superpuestas" $ do
            let d = figura 5
            let e = encimar4 d
            encimar4 (figura 5) `shouldBe` e


    describe "ciclar" $ do
        it "Un cuadrado con la misma figura rotada i * 90, i = 0, 1, 2, 3" $ do
            let d = figura 5
            let c = ciclar d
            ciclar (figura 5) `shouldBe` c
    

    describe "foldDib" $ do
        it "foldDib con figura" $ do
            let d = figura 5
            let f = foldDib id id id id (\_ _ a b -> a+b) (\_ _ a b -> a+b) (+) d
            foldDib id id id id (\_ _ a b -> a+b) (\_ _ a b -> a+b) (+) d `shouldBe` f 
        it "foldDib con rotar" $ do
            let d = figura 5
            let f = foldDib id id id id (\_ _ a b -> a+b) (\_ _ a b -> a+b) (+) (rotar d)
            foldDib id id id id (\_ _ a b -> a+b) (\_ _ a b -> a+b) (+) (rotar d) `shouldBe` f
        it "foldDib con espejar" $ do
            let d = figura 5
            let f = foldDib id id id id (\_ _ a b -> a+b) (\_ _ a b -> a+b) (+) (espejar d)
            foldDib id id id id (\_ _ a b -> a+b) (\_ _ a b -> a+b) (+) (espejar d) `shouldBe` f
        it "foldDib con rot45" $ do
            let d = figura 5
            let f = foldDib id id id id (\_ _ a b -> a+b) (\_ _ a b -> a+b) (+) (rot45 d)
            foldDib id id id id (\_ _ a b -> a+b) (\_ _ a b -> a+b) (+) (rot45 d) `shouldBe` f
        it "foldDib con apilar" $ do
            let d1 = figura 5
            let d2 = figura 6
            let f = foldDib id id id id (\_ _ a b -> a+b) (\_ _ a b -> a+b) (+) (apilar 1 1 d1 d2)
            foldDib id id id id (\_ _ a b -> a+b) (\_ _ a b -> a+b) (+) (apilar 1 1 d1 d2) `shouldBe` f
        it "foldDib con juntar" $ do
            let d1 = figura 5
            let d2 = figura 6
            let f = foldDib id id id id (\_ _ a b -> a+b) (\_ _ a b -> a+b) (+) (juntar 1 1 d1 d2)
            foldDib id id id id (\_ _ a b -> a+b) (\_ _ a b -> a+b) (+) (juntar 1 1 d1 d2) `shouldBe` f
        it "foldDib con encimar" $ do
            let d1 = figura 5
            let d2 = figura 6
            let f = foldDib id id id id (\_ _ a b -> a+b) (\_ _ a b -> a+b) (+) (encimar d1 d2)
            foldDib id id id id (\_ _ a b -> a+b) (\_ _ a b -> a+b) (+) (encimar d1 d2) `shouldBe` f
        


    describe "mapDib" $ do
        it "mapDib con figura" $ do
            let d = figura 5
            let m = mapDib figura d
            mapDib figura d `shouldBe` m
        it "mapDib con rotar" $ do
            let d = figura 5
            let m = mapDib figura (rotar d)
            mapDib figura (rotar d) `shouldBe` m
        it "mapDib con espejar" $ do
            let d = figura 5
            let m = mapDib figura (espejar d)
            mapDib figura (espejar d) `shouldBe` m
        it "mapDib con rot45" $ do
            let d = figura 5
            let m = mapDib figura (rot45 d)
            mapDib figura (rot45 d) `shouldBe` m
        it "mapDib con apilar" $ do
            let d1 = figura 5
            let d2 = figura 6
            let m = mapDib figura (apilar 1 1 d1 d2)
            mapDib figura (apilar 1 1 d1 d2) `shouldBe` m
        it "mapDib con juntar" $ do
            let d1 = figura 5
            let d2 = figura 6
            let m = mapDib figura (juntar 1 1 d1 d2)
            mapDib figura (juntar 1 1 d1 d2) `shouldBe` m
        it "mapDib con encimar" $ do
            let d1 = figura 5
            let d2 = figura 6
            let m = mapDib figura (encimar d1 d2)
            mapDib figura (encimar d1 d2) `shouldBe` m


    describe "figuras" $ do 
        it "Junta todas las figuras basicas de un dibujo" $ do
            let d = figura 5
            let f = figura d
            figura (figura 5) `shouldBe` f
        it "Ahora con un ejemplo mas complejo" $ do
            let d = figura 5
            let d1 = rotar d
            let d2 = espejar d
            let d3 = rot45 d
            let d4 = apilar 0.5 0.5 d d1
            let d5 = juntar 0.5 0.5 d2 d3
            let d6 = encimar d4 d5
            let f = figura d6
            figura (encimar (apilar 0.5 0.5 (figura 5) (rotar (figura 5))) (juntar 0.5 0.5 (espejar (figura 5)) (rot45 (figura 5)))) `shouldBe` f