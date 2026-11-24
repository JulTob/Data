--# Wiki: "2. Probability" (la playlist en Shuffle)
--#
--# Omega es un tipo enumerado: el mismo generico sirve para canciones
--# que para caras de dado. Eso es lo que significa "construir un algebra".
with Probability_Numbers; use Probability_Numbers;
with Kolmogorov_Spaces;
with Checks;              use Checks;

procedure Playlist is

    type Song is (
        Bohemian_Rhapsody,      -- Queen        1975  Rock
        In_The_End,             -- Linkin Park  2000  Rock, Rap
        I_Want_To_Break_Free,   -- Queen        1984  Rock
        Mamma_Mia,              -- ABBA         1975  Pop
        Wake_Me_Up,             -- Avicii       2013  Pop
        Lose_Yourself           -- Eminem       2002  Rap
        );

    package Space is new Kolmogorov_Spaces (Omega => Song);
    use Space;

    Shuffle : constant Measure := Uniform;

    Rock        : constant Event := (Bohemian_Rhapsody | In_The_End | I_Want_To_Break_Free => True, others => False);
    Before_2000 : constant Event := (Bohemian_Rhapsody | I_Want_To_Break_Free | Mamma_Mia => True, others => False);
    Rap         : constant Event := (In_The_End | Lose_Yourself => True, others => False);
    Pop         : constant Event := (Mamma_Mia | Wake_Me_Up => True, others => False);
    Queen       : constant Event := (Bohemian_Rhapsody | I_Want_To_Break_Free => True, others => False);

    procedure Inclusion_Exclusion is
        --# P(A or B) = P(A) + P(B) - P(A and B). El solapamiento se resta una vez.
        P_A      : constant Real := Real (Probability_Of (Shuffle, Rock));
        P_B      : constant Real := Real (Probability_Of (Shuffle, Before_2000));
        P_Both   : constant Real := Real (Probability_Of (Shuffle, Rock and Before_2000));
        P_Either : constant Real := Real (Probability_Of (Shuffle, Rock or Before_2000));
        begin
        Section ("Wiki: 2. Probability. Inclusion-exclusion");
        Check ("P(Rock)",                P_A,    3.0 / 6.0);
        Check ("P(<2000)",               P_B,    3.0 / 6.0);
        Check ("P(Rock and <2000)",      P_Both, 2.0 / 6.0);
        Check ("P(Rock or <2000) = 2/3", P_Either, 2.0 / 3.0);
        Check ("P(A or B) = P(A) + P(B) - P(A and B)", P_Either, P_A + P_B - P_Both);
        end Inclusion_Exclusion;

    procedure Disjoint_Is_Not_Independent is
        --# La wiki dice que Pop y Rap son "ortogonales" y que por eso sus
        --# probabilidades son "independientes". Lo primero es cierto (disjuntos).
        --# Lo segundo NO: independiente significa P(A and B) = P(A) P(B),
        --# y aqui 0 /= (2/6)(2/6). Dos eventos disjuntos con probabilidad
        --# positiva son siempre DEPENDIENTES: si ocurre uno, el otro no puede.
        begin
        Section ("Wiki: 2. Probability. Disjunto no implica independiente");
        Check ("P(Rock and Rap) = 1/6",        Real (Probability_Of (Shuffle, Rock and Rap)), 1.0 / 6.0);
        Check ("Rock y Rap no son disjuntos",  not Are_Disjoint (Rock, Rap));
        Check ("Pop y Rap son disjuntos",      Are_Disjoint (Pop, Rap));
        Check ("P(Pop and Rap) = 0",           Real (Probability_Of (Shuffle, Pop and Rap)), 0.0);
        Check ("P(Pop) * P(Rap) = 1/9",
               Real (Probability_Of (Shuffle, Pop)) * Real (Probability_Of (Shuffle, Rap)), 1.0 / 9.0);
        Check ("Pop y Rap NO son independientes", not Are_Independent (Shuffle, Pop, Rap));
        end Disjoint_Is_Not_Independent;

    procedure Bayes_On_The_Playlist is
        --# P(Queen | Rock) = P(Rock | Queen) P(Queen) / P(Rock)
        Posterior  : constant Real := Real (Conditional_Probability (Shuffle, Queen, Given => Rock));
        Likelihood : constant Real := Real (Conditional_Probability (Shuffle, Rock,  Given => Queen));
        Prior      : constant Real := Real (Probability_Of (Shuffle, Queen));
        Evidence   : constant Real := Real (Probability_Of (Shuffle, Rock));
        begin
        Section ("Wiki: Bayesian Statistics, sobre la playlist");
        Check ("P(Rock | Queen) = 1",       Likelihood, 1.0);
        Check ("P(Queen | Rock) = 2/3",     Posterior,  2.0 / 3.0);
        Check ("Teorema de Bayes",          Posterior,  Likelihood * Prior / Evidence);
        end Bayes_On_The_Playlist;

    begin
    Inclusion_Exclusion;
    Disjoint_Is_Not_Independent;
    Bayes_On_The_Playlist;
    Finish;
    end Playlist;
