package body Probability_Numbers is

    function Clamp_To_Probability (Value : Real) return Probability is
        begin
        if Value < 0.0 then
            return 0.0;
        elsif Value > 1.0 then
            return 1.0;
        else
            return Probability (Value);
            end if;
        end Clamp_To_Probability;

end Probability_Numbers;
