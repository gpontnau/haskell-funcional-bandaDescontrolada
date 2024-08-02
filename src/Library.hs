module Library where
import PdePreludat

doble :: Number -> Number
doble numero = numero + numero

data Genero = Genero {
    nombreGenero         :: String,
    cantidadSeguidores   :: Number,
    nivelDeDescontrolQue :: Number
} deriving (Show, Eq)
rock        = Genero "rock" 111250 3
pop         = Genero "pop" 53400 1
electronico = Genero "electrónico" 10000 4
hiphop      = Genero "hip-hop" 2000 1

data Banda = Banda {
    nombre     :: String,
    seguidores :: Number,
    estilo     :: [Genero]
} deriving (Show, Eq)
cuartetitos = Banda "emilioPrincipeYSusCuartetitosDeJulceDeLecheConCoco" 75000 [rock]
agusSinGas  = Banda "agusSinGasNoLloSurround" 61815 [rock, pop]
djCutaneo   = Banda "djCutaneoInTheHills" 2000 [electronico, hiphop]

type Festival = [Banda]

costellaFest    = [agusSinGas, djCutaneo]
noParenDeBailar = [cuartetitos, agusSinGas]

-- Punto 1
--A
descontrolTotalGenero :: Genero -> Number
descontrolTotalGenero genero = ( *cantidadSeguidores genero) . nivelDeDescontrolQue $ genero
--B
porcentajeDeRelevancia :: Banda -> Genero -> Number
porcentajeDeRelevancia banda genero
    | genero `elem` estilo banda = calcularPorcentaje banda genero
    | otherwise = 0

calcularPorcentaje :: Banda -> Genero -> Number
calcularPorcentaje banda genero = (seguidores banda / sum (map cantidadSeguidores . estilo $ banda)) * 100

cantidadTotalSeguidores :: [Genero] -> Number
cantidadTotalSeguidores = sum . map cantidadSeguidores

--C
descontrolPorGenero :: Banda -> Genero -> Number
descontrolPorGenero banda genero = descontrolTotalGenero genero * porcentajeDeRelevancia banda genero

nivelDescontrolBanda :: Banda -> Number
nivelDescontrolBanda banda = sum $ map (descontrolPorGenero banda) . estilo $ banda

-- Punto 2
-- punto 2.a --
mejorElemento :: Ord a => (b -> a) -> [b] -> b
mejorElemento f lista = foldl (mayorSegun f) (head lista) lista

mayorSegun :: Ord a => (t -> a) -> t -> t -> t
mayorSegun f a b
    | f a > f b = a
    | otherwise = b

-- 2.b --
mejorGenero :: [Genero] -> Genero
mejorGenero = mejorElemento nivelDeDescontrolQue

-- Apa de 
generoMasTocado :: [Banda] -> [Genero] -> Genero
generoMasTocado bandas = mejorElemento (contarBandas bandas)

-- Función para contar cuántas bandas tocan un género
contarBandas :: [Banda] -> Genero -> Number
contarBandas bandas genero = length (filter (tocaGenero genero) bandas)

tocaGenero :: Genero -> Banda -> Bool
tocaGenero genero banda = genero `elem` estilo banda


-- -- Cuenta cuántas bandas tocan un género
-- contarBandasPorGenero :: [Banda] -> Genero -> Number
-- contarBandasPorGenero bandas genero = length (filter (elem genero . estilo) bandas)

-- -- Punto 2.b
-- generoMasTocado :: [Banda] -> [Genero] -> Genero
-- generoMasTocado bandas = mejorElemento (contarBandasPorGenero bandas)

-- Punto 3
-- cual es el genero principal de un festival, que es el que toca la mayor cantidad de bandas principales
generoPrincipalFestival :: Festival -> Genero
generoPrincipalFestival bandas = generoMasTocado bandas (concatMap estilo bandas)

-- Punto 4
incorporarGeneros :: Banda -> [Genero] -> Banda
incorporarGeneros = foldl agregarGenero  

agregarGenero :: Banda -> Genero -> Banda
agregarGenero banda nuevoGenero = banda {
    estilo = nuevoGenero : estilo banda,
    seguidores = seguidores banda + (cantidadSeguidores nuevoGenero / 1000)
}
