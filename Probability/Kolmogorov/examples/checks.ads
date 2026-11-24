--# Checks
--#
--# Un comprobador minimo, compartido por todos los ejemplos.
--# Imprime PASS o FAIL y cuenta los fallos. No sabe nada de probabilidad.
with Probability_Numbers; use Probability_Numbers;

package Checks is

    procedure Section (Title : in String);

    --# Tolerance permite comparar con valores copiados de la wiki,
    --# que tienen unas diez cifras significativas.
    procedure Check (
            Name      : in String;
            Got       : in Real;
            Expected  : in Real;
            Tolerance : in Real := Epsilon
            );

    procedure Check (
            Name      : in String;
            Condition : in Boolean
            );

    --# Resumen final. Lanza Program_Error si hubo algun fallo,
    --# para que el proceso termine con codigo de error.
    procedure Finish;

end Checks;
