with Ada.Text_IO;    use Ada.Text_IO;
with Ada.Assertions;

procedure Contract is
   --  Ada 2012 contracts: a precondition and a postcondition on the spec.
   function Safe_Div (A, B : Integer) return Integer
     with Pre  => B /= 0,
          Post => Safe_Div'Result * B <= A;

   function Safe_Div (A, B : Integer) return Integer is
   begin
      return A / B;
   end Safe_Div;
begin
   Put_Line ("10 / 3 =" & Integer'Image (Safe_Div (10, 3)));
   Put_Line ("10 / 0 =" & Integer'Image (Safe_Div (10, 0)));
exception
   when Ada.Assertions.Assertion_Error =>
      Put_Line ("Assertion_Error: precondition B /= 0 failed");
end Contract;
