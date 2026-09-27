with Ada.Text_IO; use Ada.Text_IO;

procedure Types is
   --  Both are integers, but they are different types with their own ranges.
   type Speed_Kmh is range 0 .. 300;
   type Temp_C    is range -50 .. 60;

   Speed : Speed_Kmh := 120;
   Temp  : Temp_C    := 25;
begin
   Put_Line ("Speed:" & Speed_Kmh'Image (Speed) & " km/h");
   Put_Line ("Temp:" & Temp_C'Image (Temp) & " C");

   --  Going past the range is caught while the program runs.
   Speed := Speed * 3;
   Put_Line ("never printed");
exception
   when Constraint_Error =>
      Put_Line ("Constraint_Error: 120 * 3 is out of 0 .. 300");
end Types;
