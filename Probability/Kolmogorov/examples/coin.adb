--# Wiki: "Frequentist Probability" (moneda justa y sesgada)
--#       "Odds"                    (60% -> odds 3 a 2)
with Probability_Numbers; use Probability_Numbers;
with Kolmogorov_Spaces;
with Checks;              use Checks;

procedure Coin is

    type Face is (Head, Tail);
    package Space is new Kolmogorov_Spaces (Omega => Face);
    use Space;

    Heads : constant Event := (Head => True, Tail => False);

    Fair   : constant Measure := Uniform;
    Biased : constant Measure := Make ((Head => 0.8, Tail => 0.2));
    Team   : constant Measure := Make ((Head => 0.6, Tail => 0.4));  -- Head = "gana"

    begin
    Section ("Wiki: Frequentist Probability");
    Check ("Justa:   P(Head) = |{Head}| / |Omega| = 1/2", Real (Probability_Of (Fair, Heads)),   0.5);
    Check ("Sesgada: P(Head) = 0.8",                       Real (Probability_Of (Biased, Heads)), 0.8);
    Check ("Sesgada: P(Tail) = 1 - 0.8",                   Real (Probability_Of_Complement (Biased, Heads)), 0.2);
    Check ("Contar caras no establece la justicia: P(Head) /= 1/2",
           Real (Probability_Of (Biased, Heads)) /= 0.5);

    Section ("Wiki: Odds. P = 0.6 -> 3 a 2 a favor");
    Check ("Odds(gana) = 0.6 / 0.4 = 3/2", Odds_In_Favour (Team, Heads), 1.5);
    Check ("Odds(justa) = 1",              Odds_In_Favour (Fair, Heads), 1.0);
    Finish;
    end Coin;
