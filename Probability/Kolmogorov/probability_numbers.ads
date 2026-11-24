--# Probability_Numbers
--#
--# La capa mas baja: los numeros con los que se construye la teoria.
--# No sabe nada de espacios, eventos ni medidas. Solo de reales y de [0,1].
package Probability_Numbers is

    --# Un real de proposito general para variables aleatorias y esperanzas.
    type Real is digits 15;

    --# Una probabilidad. El rango [0,1] es parte del tipo:
    --# asignar 1.3 o -0.1 es un error detectado por Ada, no por nosotros.
    --# Esto es el Axioma 1 (no negatividad) convertido en tipo.
    type Probability is digits 15 range 0.0 .. 1.0;

    --# Tolerancia para comparar sumas de reales. Los flotantes no suman exacto.
    Epsilon : constant Real := 1.0E-12;

    function Almost_Equal (
            A, B      : Real;
            Tolerance : Real := Epsilon
            ) return Boolean is
        (abs (A - B) <= Tolerance);

    --# Recorta el redondeo residual de un calculo que, en teoria,
    --# ya deberia estar dentro de [0,1].
    function Clamp_To_Probability (Value : Real) return Probability;

end Probability_Numbers;
