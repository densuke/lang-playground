C     昔風の制御構造。算術 IF (3 分岐)、計算型 GOTO、GOTO による反復。
C     いずれも現代の規格では廃止または削除された機能。
      PROGRAM OLDFLO
      DO 50 N = -1, 1
C        算術 IF: 値が負なら 10、零なら 20、正なら 30 の文番号へ飛ぶ
         IF (N) 10, 20, 30
   10    WRITE (*, *) N, ' は負'
         GO TO 40
   20    WRITE (*, *) N, ' は零'
         GO TO 40
   30    WRITE (*, *) N, ' は正'
   40    CONTINUE
   50 CONTINUE
      END
