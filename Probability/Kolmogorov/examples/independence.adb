--# Wiki: "1.3 Independence"
--#   1. U, V bits justos, W = U xor V: independientes dos a dos, no los tres.
--#   2. Condicionar a W = 0 hace dependientes a U y V.
--#   3. X uniforme en {-1,0,1}, Y = X^2: covarianza cero pero dependientes.
with Probability_Numbers; use Probability_Numbers;
with Kolmogorov_Spaces;
with Checks;              use Checks;

procedure Independence is

    ------------------------------------------------------------------
    procedure Xor_Bits is
        --# Omega: los cuatro pares (U, V). W queda determinado.
        type Bit_Pair is (UV_00, UV_01, UV_10, UV_11);
        package Space is new Kolmogorov_Spaces (Omega => Bit_Pair);
        use Space;

        Law : constant Measure := Uniform;

        U_Is_0 : constant Event := (UV_00 | UV_01 => True, others => False);
        V_Is_0 : constant Event := (UV_00 | UV_10 => True, others => False);
        W_Is_0 : constant Event := (UV_00 | UV_11 => True, others => False);  -- U = V

        All_Three_Zero : constant Event := U_Is_0 and V_Is_0 and W_Is_0;
        begin
        Section ("Wiki: Independence. W = U xor V");
        Check ("U y V independientes", Are_Independent (Law, U_Is_0, V_Is_0));
        Check ("U y W independientes", Are_Independent (Law, U_Is_0, W_Is_0));
        Check ("V y W independientes", Are_Independent (Law, V_Is_0, W_Is_0));
        Check ("P(U=0, V=0, W=0) = 1/4", Real (Probability_Of (Law, All_Three_Zero)), 0.25);
        Check ("... pero (1/2)^3 = 1/8: no hay independencia mutua",
               Real (Probability_Of (Law, All_Three_Zero)) /= 0.125);

        Section ("Wiki: Independence. Condicionar a W = 0");
        Check ("P(U=0, V=0 | W=0) = 1/2",
               Real (Conditional_Probability (Law, U_Is_0 and V_Is_0, Given => W_Is_0)), 0.5);
        Check ("P(U=0 | W=0) P(V=0 | W=0) = 1/4",
               Real (Conditional_Probability (Law, U_Is_0, Given => W_Is_0))
               * Real (Conditional_Probability (Law, V_Is_0, Given => W_Is_0)), 0.25);
        end Xor_Bits;

    ------------------------------------------------------------------
    procedure Zero_Covariance_Is_Not_Independence is
        type Value is range -1 .. 1;
        package Space is new Kolmogorov_Spaces (Omega => Value);
        use Space;

        Law : constant Measure := Uniform;

        function X  (W : Value) return Real is (Real (W));
        function XY (W : Value) return Real is (Real (W) ** 3);   -- X * X^2

        X_Is_0 : constant Event := (0 => True, others => False);
        Y_Is_0 : constant Event := X_Is_0;   -- Y = X^2 = 0 exactamente cuando X = 0

        Cov : constant Real := Expectation (Law, XY'Access)
                             - Expectation (Law, X'Access) * Expectation (Law, X'Access);
        begin
        Section ("Wiki: Independence. X uniforme en {-1,0,1}, Y = X^2");
        Check ("E[X] = 0",         Expectation (Law, X'Access),  0.0);
        Check ("E[XY] = 0",        Expectation (Law, XY'Access), 0.0);
        Check ("Cov(X, Y) = 0",    Cov, 0.0);
        Check ("P(X=0, Y=0) = 1/3", Real (Probability_Of (Law, X_Is_0 and Y_Is_0)), 1.0 / 3.0);
        Check ("P(X=0) P(Y=0) = 1/9",
               Real (Probability_Of (Law, X_Is_0)) * Real (Probability_Of (Law, Y_Is_0)), 1.0 / 9.0);
        Check ("X e Y NO son independientes", not Are_Independent (Law, X_Is_0, Y_Is_0));
        end Zero_Covariance_Is_Not_Independence;

    begin
    Xor_Bits;
    Zero_Covariance_Is_Not_Independence;
    Finish;
    end Independence;
