begin
   comment 名前呼び (call by name) と Jensen's device。
      sum の引数 i と term は値でなく式そのものが渡され、参照のたびに評価し直される;
   real procedure sum (i, lo, hi, term);
      value lo, hi; integer i, lo, hi; real term;
   begin
      real s;
      s := 0;
      for i := lo step 1 until hi do s := s + term;
      sum := s
   end;
   integer k;
   real array a[1:5];
   for k := 1 step 1 until 5 do a[k] := k * k;
   outstring (1, "sum of k, k=1..100 = "); outreal (1, sum (k, 1, 100, k)); outstring (1, "\n");
   outstring (1, "sum of a[k], k=1..5 = "); outreal (1, sum (k, 1, 5, a[k])); outstring (1, "\n");
   outstring (1, "sum of 1/k^2, k=1..1000 = "); outreal (1, sum (k, 1, 1000, 1 / (k * k))); outstring (1, "\n")
end
