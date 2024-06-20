---
title: Laboratorio de Funcional
author: Tomás Romanutti, Fabrizio Longhi, Bruno Joaquín Espinosa
---

# Paradigmas de Programación

*Tomás Romanutti, Fabrizio Longhi, Bruno Joaquín Espinosa*

## 1. Elementos del laboratorio
Esta es una lista de las cosas que hemos implementado a lo largo del laboratorio.

### 1.1. Lenguaje
- Módulo `Dibujo.hs` con el tipo `Dibujo` y combinadores.
- Definición de funciones (esquemas) para la manipulación de dibujos.
- Módulo `Pred.hs`.

### 1.2. Interpretación geométrica
- Módulo `Interp.hs`.

### 1.3. Expresión artística
- Módulo `Dibujos/Grilla.hs`.
- Módulo `Dibujos/Escher.hs`.
- Dibujos extras.
- Listado de dibujos en `Main.hs`.

### 1.4 Tests
- Tests para `Dibujo.hs`.
- Tests para `Pred.hs`.

## 2. Experiencia
En este proyecto de laboratorio tuvimos que implementar, entre otras cosas, un lenguaje para interpretar dibujos usando fórmulas para modificar figuras básicas. Este proyecto nos resultó bastante largo y en algunas partes difícil.

Nuestras mayores dificultades fueron las siguientes: la sintaxis de Haskell (en especial en el contexto del cuatrimestre, estamos usando Python, C y Haskell al mismo tiempo y nos solíamos confundir), las definiciones de tipos (Output y FloatingPic, en particular) y la forma y orden de pasar los argumentos en las funciones de Interp.hs. Terminamos usando las definiciones dadas por Henderson, por ejemplo api (f g) (d h w), pero no sabíamos por qué funcionaban de esta manera.

El artículo de Geometría Funcional ayudó muchísimo para la implementación de Interp.hs y para crear el dibujo de Escher, el cual nosotros creamos con la figura básica "F" de Feo.hs. 
## 3. Preguntas

### 3.1 ¿Por qué están separadas las funcionalidades en los módulos indicados? Explicar detalladamente la responsabilidad de cada módulo.
Las funcionalidades están separadas en dos módulos: Dibujo.hs, Interp.hs y Pred.hs. Cada una tiene cierta estructura y una función específica que tiene que ser realizada sin errores.

**Dibujo.hs**, con su tipo `Dibujo`, se encarga de armar la estructura de la imagen mediante funciones (que nosotros lo interpretamos como una especie de árbol). Esta es la interfaz sobre la que trabajamos, y aquí se definen las funciones que necesita el usuario para declarar la imagen.

**Interp.hs** se encarga de interpretar el dibujo creado, aplicando las definiciones matemáticas de cada función sobre la estructrua de la imagen que creamos. Es la implementación de las funciones de Dibujo.hs, y el usuario solo interactua con esta parte del código cuando declara una figura.

**Pred.hs** es un módulo de funciones auxiliares que ayuda al usuario a modificar la estructura de la imagen con más facilidad.

### 3.2 ¿Por qué las figuras básicas no están incluidas en la definición del lenguaje, y en vez de eso, es un parámetro del tipo?
Las figuras básicas no están incluidas en el lenguaje para brindar flexibilidad a la hora de definir tus propias figuras y no limitarte a usar un conjunto discreto de figuras definidas por nosotros.

Gloss permite crear todo tipo de formas, incluyendo texto, por lo que la cantidad de figuras básicas que se pueden definir es virtualmente infinita. Además esto permite tratar una figura compuesta de otras como básica. Por ejemplo, se puede definir "cuadradoYTriángulo" como una figura básica que sea un cuadrado y un triángulo, en vez de usar dos figuras básicas de triángulo y cuadrado (esto suponiendo incluso que las hayamos definido!)

### 3.3 ¿Qué ventaja tiene utilizar una función de `fold` sobre hacer pattern-matching directo?
La ventaja de usar `fold` sobre pattern-matching es que el código resultante es más entendible y es menos propenso a errores, ya que en nuestro caso el pattern-matching tiene varios casos que cada uno tiene que tener los argumentos necesarios (que pueden llegar a ser varios). En cambio, fold reduce las n lineas de pattern-matching (siendo n cada patrón) a tan solo 1.

### 3.4 ¿Cuál es la diferencia entre los predicados definidos en Pred.hs y los tests?
Los predicados de **Pred.hs** se definen de manera distinta (y más simple) a los predicados que usamos para probar nuestro código, que provienen del módulo **Test.Hspec**.

`type Pred a = a -> Bool `
Como vemos en nuestro código, `Pred a` es un tipo de funciones que toman un parámetro y devuelven `True` o `False`. Sirve para verificar alguna propiedad del tipo al que le pasamos (en las funciones que definimos, esos tipos son las Figuras Básicas).
Sin embargo, la manera en la que se definen los predicados en `Hspec` es más compleja. Los predicados de declaran de la siguiente manera:

`describe "Conjunto de test" $ do`

   `it "Predicado" $ do`

   `-- Código Predicado`

Siendo `Conjunto de test` un string que simboliza un nombre para el conjunto de predicados que se van a declarar, y `Predicado` el nombre de cada predicado en sí. Esto no devuelve un Bool, sino un IO que indica el éxito o fracaso de la prueba, que se verifica con un assert al final del código (en nuestras pruebas siempre usamos `shouldBe`) 

## 4. Extras

Agregamos un nuevo dibujo, **Efes.hs**, que es el resultado de simplemente cambiar la figura básica en el dibujo de Escher por la de una F. El diseño nos pareció bonito, parecido al de un laberinto, así que decidimos dejarlo aparte.