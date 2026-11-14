C     固定形式 (FORTRAN 77 風)。1 桁目の C はコメント、
C     1-5 桁目は文番号、6 桁目は継続行の印、7-72 桁目が文。
C     72 桁より右は読み捨てられる。
      PROGRAM FIXED
C     宣言していない変数は名前の頭文字で型が決まる (I-N は整数、他は実数)
      ISUM = 0
      DO 10 I = 1, 10
         ISUM = ISUM + I
   10 CONTINUE
      X = ISUM / 4
      Y = ISUM / 4.0
      WRITE (*, 100) ISUM, X, Y
  100 FORMAT (1X, 'SUM =', I4, '  X =', F6.2, '  Y =', F6.2)
      END
