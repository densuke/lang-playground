C     FORTRAN 66 以前の書き方: ホレリス定数 (文字数 H 文字列) を整数変数に入れる。
C     文字型が無かった時代の文字列の扱い。現代の規格では削除済み。
      PROGRAM HOLLER
      INTEGER MSG(2)
      DATA MSG /4HFORT, 4HRAN /
      WRITE (*, 10) MSG
   10 FORMAT (1X, 2A4)
      END
