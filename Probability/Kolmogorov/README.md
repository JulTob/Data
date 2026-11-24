# Kolmogorov_Spaces

Un espacio de probabilidad (Ω, 𝒜, ℙ) de Kolmogorov sobre un espacio muestral finito,
escrito como paquete genérico de Ada 2012. Los tres axiomas son contratos del paquete:

| Axioma | Dónde vive en el código |
|---|---|
| 1. No negatividad, ℙ(A) ≥ 0 | el tipo `Probability` tiene rango `0.0 .. 1.0` |
| 2. Normalización, ℙ(Ω) = 1 | `Type_Invariant` del tipo privado `Measure` |
| 3. Aditividad | `Post` de `Probability_Of_Union` |

Es el laboratorio ejecutable de las notas de la [wiki](https://github.com/JulTob/Data/wiki).
Cada programa de `examples/` reproduce los números de una o más páginas.

## Capas

```
examples/*.adb            los ejemplos de la wiki, uno por tema
examples/checks.*         un comprobador PASS/FAIL compartido
kolmogorov_spaces.*       (Ω, 𝒜, ℙ): eventos, medida, condicional, independencia, odds,
                          variables aleatorias, esperanza y varianza
probability_numbers.*     los números: Real, Probability en [0,1], tolerancia
```

## Páginas de la wiki cubiertas

| Programa | Páginas de la wiki | Qué comprueba |
|---|---|---|
| `die` | Kolmogorov: Ω, 𝒜, ℙ · Outcomes and Events | ℙ(A) = \|A\|/6, A∩B, A∪B, E[X] = 3.5, y que los contratos rechazan medidas y uniones inválidas |
| `playlist` | 2. Probability · Bayesian Statistics | inclusión-exclusión ℙ(Rock ∪ <2000) = 2/3, Bayes, y que disjunto no implica independiente |
| `coin` | Frequentist Probability · Odds | moneda justa y sesgada, odds 3 a 2 |
| `distributions` | Bernoulli · Uniforme · Binomial | esperanza y varianza de las tres tablas |
| `independence` | 1.3 Independence | W = U xor V independiente dos a dos pero no mutuamente; covarianza cero sin independencia |

## Compilar y ejecutar

Necesita GNAT. El interruptor `-gnata` activa la comprobación de contratos
(Pre, Post, Type_Invariant) en ejecución; sin él se compilan pero no se comprueban.

```bash
./build_and_run.sh
```

o un ejemplo a mano:

```bash
gnatmake -gnata -gnatwa -gnat2012 -I. -Iexamples -D obj -o obj/die examples/die.adb
./obj/die
```
