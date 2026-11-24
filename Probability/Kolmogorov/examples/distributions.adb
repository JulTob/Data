--# Wiki: "2.2.1 Variable de Bernoulli"  p = 0.25
--#       "2.2.3 Variable Uniforme"      L = 10
--#       "2.2.2 Binomial"               n = 20, p = 0.1
--#
--# Una distribucion discreta ES una medida sobre un Omega finito.
--# La esperanza y la varianza salen de la misma integral de siempre.
with Probability_Numbers; use Probability_Numbers;
with Kolmogorov_Spaces;
with Checks;              use Checks;

procedure Distributions is

    ------------------------------------------------------------------
    procedure Bernoulli is
        type Outcome is (Failure, Success);
        package Space is new Kolmogorov_Spaces (Omega => Outcome);
        use Space;

        P_Success : constant Probability := 0.25;
        Law : constant Measure := Make ((Failure => 1.0 - P_Success, Success => P_Success));

        function X (W : Outcome) return Real is
            (if W = Success then 1.0 else 0.0);
        begin
        Section ("Wiki: Bernoulli, p = 0.25");
        Check ("E[X] = p",          Expectation (Law, X'Access), 0.25);
        Check ("Var[X] = p (1 - p)", Variance (Law, X'Access),  0.1875);
        end Bernoulli;

    ------------------------------------------------------------------
    procedure Uniform_On_Ten is
        type Value is range 1 .. 10;
        package Space is new Kolmogorov_Spaces (Omega => Value);
        use Space;

        Law : constant Measure := Uniform;

        function X (W : Value) return Real is (Real (W));
        begin
        Section ("Wiki: Uniforme, L = 10");
        Check ("P({k}) = 1/L",        Real (Mass_Of (Law, 7)), 0.1);
        Check ("E[X] = (L + 1) / 2",   Expectation (Law, X'Access), 5.5);
        Check ("Var[X] = (L^2 - 1)/12", Variance (Law, X'Access),   8.25);
        end Uniform_On_Ten;

    ------------------------------------------------------------------
    procedure Binomial is
        N : constant := 20;
        type Success_Count is range 0 .. N;
        package Space is new Kolmogorov_Spaces (Omega => Success_Count);
        use Space;

        P_Success : constant Real := 0.1;

        --# C(n, k) calculado con el producto iterativo, sin factoriales grandes.
        function Binomial_Coefficient (K : Success_Count) return Real is
            Result : Real := 1.0;
            begin
            for I in 1 .. Integer (K) loop
                Result := Result * Real (N - I + 1) / Real (I);
                end loop;
            return Result;
            end Binomial_Coefficient;

        --# P(X = k) = C(n,k) p^k (1-p)^(n-k)
        function Binomial_Mass return Mass_Function is
            Mass : Mass_Function;
            begin
            for K in Success_Count loop
                Mass (K) := Probability (
                    Binomial_Coefficient (K)
                    * P_Success ** Integer (K)
                    * (1.0 - P_Success) ** Integer (N - K)
                    );
                end loop;
            return Mass;
            end Binomial_Mass;

        Law : constant Measure := Make (Binomial_Mass);   -- Make exige que sume 1

        function X (W : Success_Count) return Real is (Real (W));

        At_Most_Two : constant Event := (0 | 1 | 2 => True, others => False);
        begin
        Section ("Wiki: Binomial, n = 20, p = 0.1");
        Check ("P(X = 0) = 0.9^20",   Real (Mass_Of (Law, 0)), 0.9 ** 20);
        Check ("P(X = 2)",            Real (Mass_Of (Law, 2)), 0.2851798071, Tolerance => 1.0E-9);
        Check ("P(X <= 2)",           Real (Probability_Of (Law, At_Most_Two)), 0.1215766546 + 0.2701703435 + 0.2851798071, Tolerance => 1.0E-9);
        Check ("E[X] = n p = 2",      Expectation (Law, X'Access), 2.0);
        Check ("Var[X] = n p (1-p) = 1.8", Variance (Law, X'Access), 1.8);
        end Binomial;

    begin
    Bernoulli;
    Uniform_On_Ten;
    Binomial;
    Finish;
    end Distributions;
