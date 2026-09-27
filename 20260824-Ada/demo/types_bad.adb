with Ada.Text_IO; use Ada.Text_IO;

procedure Types_Bad is
   type Speed_Kmh is range 0 .. 300;
   type Temp_C    is range -50 .. 60;

   Speed : Speed_Kmh := 120;
   Temp  : Temp_C    := 25;
begin
   --  Putting a temperature into a speed: the compiler refuses.
   Speed := Temp;
   Put_Line (Speed_Kmh'Image (Speed));
end Types_Bad;
