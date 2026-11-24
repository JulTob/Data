--# Wiki: "Kolmogorov: Ω, 𝒜, ℙ" (ejemplo del dado justo)
--#       "Outcomes and Events"  (A = {2,4,6}, B = {4,5,6})
--#
--# Ademas comprueba que los contratos RECHAZAN lo que viola los axiomas.
with Ada.Assertions;
with Probability_Numbers; use Probability_Numbers;
with Kolmogorov_Spaces;
with Checks;              use Checks;

procedure Die is

    type Die_Face is range 1 .. 6;
    package Space is new Kolmogorov_Spaces (Omega => Die_Face);
    use Space;

    Fair : constant Measure := Uniform;

    Even        : constant Event := (2 | 4 | 6 => True, others => False);  -- A
    Greater_3   : constant Event := (4 | 5 | 6 => True, others => False);  -- B
    One         : constant Event := (1 => True, others => False);
    Six         : constant Event := (6 => True, others => False);

    function Face_Value (W : Die_Face) return Real is (Real (W));

    procedure Kolmogorov_Page is
        begin
        Section ("Wiki: Kolmogorov. P(Event) = |Event| / 6");
        Check ("P({2,4,6})", Real (Probability_Of (Fair, Even)), 1.0 / 2.0);
        Check ("P({1})",     Real (Probability_Of (Fair, One)),  1.0 / 6.0);
        Check ("P(Omega)",   Real (Probability_Of (Fair, Certain_Event)), 1.0);
        Check ("P(vacio)",   Real (Probability_Of (Fair, Impossible_Event)), 0.0);
        Check ("|Even| = 3", Cardinality (Even) = 3);
        end Kolmogorov_Page;

    procedure Outcomes_And_Events_Page is
        begin
        Section ("Wiki: Outcomes and Events. A = par, B = mayor que 3");
        Check ("A and B = {4,6}",     Real (Probability_Of (Fair, Even and Greater_3)), 2.0 / 6.0);
        Check ("A or B = {2,4,5,6}",  Real (Probability_Of (Fair, Even or Greater_3)),  4.0 / 6.0);
        Check ("not A = impar",       Real (Probability_Of_Complement (Fair, Even)),     1.0 / 2.0);
        Check ("Six esta en A y en B", Is_Subset (Six, Even and Greater_3));
        end Outcomes_And_Events_Page;

    procedure Axioms_As_Theorems is
        begin
        Section ("Axiomas y teoremas derivados");
        Check ("Axioma 3: P(A or not A) = P(A) + P(not A)",
               Real (Probability_Of_Union (Fair, Even, not Even)), 1.0);
        Check ("E[X] = 3.5",      Expectation (Fair, Face_Value'Access), 3.5);
        Check ("Var[X] = 35/12",  Variance (Fair, Face_Value'Access), 35.0 / 12.0);
        Check ("Odds(Six) = 1:5", Odds_In_Favour (Fair, Six), 1.0 / 5.0);
        end Axioms_As_Theorems;

    procedure Contracts_Reject_Violations is
        begin
        Section ("Los contratos rechazan lo invalido");
        begin
            declare
                Bad : constant Measure := Make ((1 => 0.6, others => 0.1));  -- suma 1.1
                begin
                Check ("Make acepto una masa que suma 1.1: " & Probability'Image (Mass_Of (Bad, 1)), False);
                end;
        exception
            when Ada.Assertions.Assertion_Error =>
                Check ("Make rechaza una masa que suma 1.1 (Axioma 2)", True);
            end;
        begin
            declare
                P : constant Probability := Probability_Of_Union (Fair, Even, Greater_3);  -- comparten 4 y 6
                begin
                Check ("Union aditiva acepto eventos no disjuntos: " & Probability'Image (P), False);
                end;
        exception
            when Ada.Assertions.Assertion_Error =>
                Check ("Probability_Of_Union rechaza eventos no disjuntos (Axioma 3)", True);
            end;
        begin
            declare
                P : constant Probability := Conditional_Probability (Fair, Even, Impossible_Event);
                begin
                Check ("Condicionar sobre el vacio devolvio: " & Probability'Image (P), False);
                end;
        exception
            when Ada.Assertions.Assertion_Error =>
                Check ("Conditional_Probability rechaza condicionar sobre P(Given) = 0", True);
            end;
        end Contracts_Reject_Violations;

    begin
    Kolmogorov_Page;
    Outcomes_And_Events_Page;
    Axioms_As_Theorems;
    Contracts_Reject_Violations;
    Finish;
    end Die;
