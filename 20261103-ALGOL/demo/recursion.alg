begin
   comment 再帰。手続き本体の中で自分自身を呼ぶ (報告書 5.4.4 節);
   integer procedure fact (n); value n; integer n;
      fact := if n = 0 then 1 else n * fact (n - 1);
   integer i;
   for i := 0 step 1 until 10 do
   begin
      outinteger (1, i); outstring (1, "! = "); outinteger (1, fact (i)); outstring (1, "\n")
   end
end
