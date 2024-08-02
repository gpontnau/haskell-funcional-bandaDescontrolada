# ♫¡Hay una banda descontrolada!♪

Se planea organizar una serie de festivales de música, y tenemos ganas de armar un modelo informatizado de los mismos para llevar a cabo el control del descontrol (¿?) que puede llegar a ocurrir, de puros ñoños que somos.

Para cada género se tiene el nombre del mismo, la cantidad de seguidores y el nivel de descontrol que genera cada uno de los mismos en un festival:

```haskell
data Genero = Genero {
    nombreGenero         :: String,
    cantidadSeguidores   :: Number,
    nivelDeDescontrolQue :: Number
} deriving (Show, Eq)

rock        = Genero "rock" 111250 3
pop         = Genero "pop" 53400 1
electronico = Genero "electrónico" 10000 4
hiphop      = Genero "hip-hop" 2000 1
```

A su vez, de las bandas que pueden llegar a tocar en los festivales se conoce el nombre, la cantidad de seguidores propios que tiene y el estilo de música que toca (lo indicamos como un conjunto de géneros):

```haskell
data Banda = Banda {
    nombre     :: String,
    seguidores :: Number,
    estilo     :: [Genero]
} deriving (Show, Eq)

cuartetitos = Banda "emilioPrincipeYSusCuartetitosDeJulceDeLecheConCoco" 75000 [rock]
agusSinGas  = Banda "agusSinGasNoLloSurround" 61815 [rock, pop]
djCutaneo   = Banda "djCutaneoInTheHills" 2000 [electronico, hiphop]
```

De los festivales se conocen las bandas participantes en el mismo.

```haskell
type Festival = [Banda]
costellaFest    = [agusSinGas, djCutaneo]
noParenDeBailar = [cuartetitos, agusSinGas]
```

Aplicando a menos una vez cada uno de los siguientes conceptos (señalar dónde se usa):

* Orden Superior
* Aplicación parcial
* Composición

Se pide desarrollar las funciones (incluyendo la declaración del tipo correspondiente) que resuelvan los requerimientos detallados a continuación.

1. Desarrollar las funciones necesarias para determinar:
   
   a. El nivel de descontrol total de un género, que se calcula en base a la cantidad de seguidores multiplicada por el nivel de descontrol que genera.
   
   b. El porcentaje de relevancia de una banda para un género, el cual se mide en base a la cantidad de seguidores de esa banda respecto de la cantidad total de seguidores del género. Si esa banda no tiene a ese género entre sus estilos, la relevancia debería ser 0.
   
   c. El nivel de descontrol de una banda, que es la suma del descontrol de cada género que conforma su estilo multiplicado por el porcentaje de relevancia de la banda para dicho género.

2. 
   a. Desarrollar una función que obtenga el mejor elemento de una lista en base a una ponderación. El mejor elemento sería aquel que maximice esa ponderación.
   
   b. Utilizando la función anterior, desarrollar 2 funciones mediante las cuales se pueda determinar:
   - A partir de una lista de géneros, cuál es el género con mayor nivel de descontrol total.
   - A partir de una lista de bandas y una de géneros, cuál es el género tocado por más bandas.

3. Saber cuál es el género principal de un festival, que es aquel que toca la mayor cantidad de bandas participantes.

4. Necesitamos que una banda pueda incorporar nuevos géneros a su estilo de música. Cada género nuevo que incorpora, además de pasar a formar parte de su estilo, le suma a la banda la milésima parte de los seguidores que ya tiene ese género. Mostrar cómo se haría para que djCutaneo incorpore los géneros rock y pop.