with Ada.Text_IO; use Ada.Text_IO;

package body Checks is

    Failures : Natural := 0;

    procedure Section (Title : in String) is
        begin
        New_Line;
        Put_Line (Title);
        end Section;

    procedure Check (
            Name      : in String;
            Got       : in Real;
            Expected  : in Real;
            Tolerance : in Real := Epsilon
            ) is
        begin
        if Almost_Equal (Got, Expected, Tolerance) then
            Put_Line ("  PASS  " & Name & " = " & Real'Image (Got));
        else
            Failures := Failures + 1;
            Put_Line ("  FAIL  " & Name
                      & " got " & Real'Image (Got)
                      & " expected " & Real'Image (Expected));
            end if;
        end Check;

    procedure Check (
            Name      : in String;
            Condition : in Boolean
            ) is
        begin
        if Condition then
            Put_Line ("  PASS  " & Name);
        else
            Failures := Failures + 1;
            Put_Line ("  FAIL  " & Name);
            end if;
        end Check;

    procedure Finish is
        begin
        New_Line;
        if Failures = 0 then
            Put_Line ("Todas las comprobaciones pasaron.");
        else
            Put_Line ("Fallos:" & Natural'Image (Failures));
            raise Program_Error with "comprobaciones fallidas";
            end if;
        end Finish;

end Checks;
