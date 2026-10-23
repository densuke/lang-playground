begin
   comment ブロックと有効範囲。内側のブロックで x を宣言し直すと外の x は隠れる;
   integer x;
   x := 1;
   outstring (1, "outer x = "); outinteger (1, x); outstring (1, "\n");
   begin
      integer x;
      x := 100;
      outstring (1, "inner x = "); outinteger (1, x); outstring (1, "\n")
   end;
   outstring (1, "outer x = "); outinteger (1, x); outstring (1, "\n")
end
