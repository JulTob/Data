--# Kolmogorov_Spaces
--#
--# Un espacio de probabilidad (Omega, A, P) sobre un espacio muestral FINITO.
--# Sigue la pagina de la wiki "Kolmogorov: Ω, 𝒜, ℙ".
--#
--#   Omega : cualquier tipo discreto (enumerado o entero acotado).
--#   A     : la sigma-algebra. Sobre un Omega finito es el conjunto potencia,
--#           asi que un Evento es simplemente un subconjunto de Omega.
--#   P     : la medida. Una funcion de masa sobre los atomos de Omega.
--#
--# Los tres axiomas de Kolmogorov aparecen como contratos, no como comentarios:
--#   Axioma 1 (no negatividad) : el tipo Probability no admite valores fuera de [0,1].
--#   Axioma 2 (normalizacion)  : Type_Invariant de Measure, P(Omega) = 1.
--#   Axioma 3 (aditividad)     : Post de Probability_Of_Union.
with Probability_Numbers; use Probability_Numbers;

generic
    type Omega is (<>);
package Kolmogorov_Spaces is

    ------------------------------------------------------------------
    -- A : el algebra de eventos
    ------------------------------------------------------------------

    --# Un evento es un subconjunto de Omega: True donde el atomo pertenece.
    --# Wiki, "Outcomes and Events": un resultado es un punto, un evento una region.
    type Event is array (Omega) of Boolean;

    Certain_Event    : constant Event := (others => True);   -- Omega
    Impossible_Event : constant Event := (others => False);  -- conjunto vacio

    --# Sobrecargar los operadores permite escribir teoremas como se leen.
    function "not" (A : Event) return Event;        -- complemento
    function "and" (A, B : Event) return Event;     -- interseccion
    function "or"  (A, B : Event) return Event;     -- union

    function Are_Disjoint (A, B : Event) return Boolean;
    function Is_Subset    (A, B : Event) return Boolean;   -- A contenido en B
    function Cardinality  (A : Event) return Natural;      -- |A|

    ------------------------------------------------------------------
    -- P : la medida de probabilidad
    ------------------------------------------------------------------

    --# Una funcion de masa: cuanto pesa cada atomo.
    --# Es publica para que el usuario pueda construir medidas a mano.
    type Mass_Function is array (Omega) of Probability;

    function Total_Mass (M : Mass_Function) return Real;

    function Is_Normalised (M : Mass_Function) return Boolean is
        (Almost_Equal (Total_Mass (M), 1.0));

    --# La medida es privada: nadie puede fabricar una que viole el Axioma 2.
    type Measure is private
        with Type_Invariant => Satisfies_Normalisation (Measure);

    function Satisfies_Normalisation (P : Measure) return Boolean;

    --# Constructores.

    --# Equiprobable: P(A) = |A| / |Omega|. Wiki, "Frequentist Probability".
    function Uniform return Measure;

    function Make (
            Mass : in Mass_Function
            ) return Measure
        with Pre => Is_Normalised (Mass);

    --# Consultas.
    function Mass_Of (
            P : in Measure;
            W : in Omega
            ) return Probability;

    function Probability_Of (
            P : in Measure;
            A : in Event
            ) return Probability;

    --# Axioma 3, aditividad finita, como poscondicion.
    function Probability_Of_Union (
            P    : in Measure;
            A, B : in Event
            ) return Probability
        with
            Pre  => Are_Disjoint (A, B),
            Post => Almost_Equal (
                        Real (Probability_Of_Union'Result),
                        Real (Probability_Of (P, A)) + Real (Probability_Of (P, B))
                        );

    --# Teorema derivado: P(not A) = 1 - P(A).
    function Probability_Of_Complement (
            P : in Measure;
            A : in Event
            ) return Probability
        with Post => Almost_Equal (
                        Real (Probability_Of_Complement'Result),
                        1.0 - Real (Probability_Of (P, A))
                        );

    ------------------------------------------------------------------
    -- Condicionar, independencia y odds
    ------------------------------------------------------------------

    --# P(A | Given) = P(A and Given) / P(Given).  Wiki, "Bayesian Statistics".
    --# Condicionar sobre un evento de probabilidad cero no tiene sentido.
    function Conditional_Probability (
            P     : in Measure;
            A     : in Event;
            Given : in Event
            ) return Probability
        with Pre => Probability_Of (P, Given) > 0.0;

    --# A y B son independientes si P(A and B) = P(A) * P(B).  Wiki, "Independence".
    --# Nota: disjunto NO es lo mismo que independiente. Ver examples/playlist.
    function Are_Independent (
            P    : in Measure;
            A, B : in Event
            ) return Boolean;

    --# Odds a favor: P(A) / P(not A).  Wiki, "Odds".
    function Odds_In_Favour (
            P : in Measure;
            A : in Event
            ) return Real
        with Pre => Probability_Of (P, not A) > 0.0;

    ------------------------------------------------------------------
    -- Variables aleatorias y esperanza
    ------------------------------------------------------------------

    --# Una variable aleatoria es una funcion medible Omega -> Real.
    --# En un espacio finito toda funcion es medible.
    type Random_Variable is access function (W : Omega) return Real;

    --# Integral de Lebesgue respecto a P.
    --# En el caso finito es una suma ponderada: E[X] = sum X(w) * P({w}).
    function Expectation (
            P : in Measure;
            X : in Random_Variable
            ) return Real;

    --# Var[X] = E[(X - E[X])^2]. Nunca negativa.
    function Variance (
            P : in Measure;
            X : in Random_Variable
            ) return Real
        with Post => Variance'Result >= -Epsilon;

private

    type Measure is record
        Mass : Mass_Function;
        end record;

end Kolmogorov_Spaces;
