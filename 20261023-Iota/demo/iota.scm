;; Iota の参照実装。Chris Barker, "Iota and Jot: the simplest languages?" より原文のまま。
;; 出典: https://web.archive.org/web/20201112014512/http://www.nyu.edu/projects/barker/Iota/
;; 標準入力から整形式の Iota 式を 1 つ読み、その式が表す関数を返す。
(define (read-iota)
  (let iota ()
    (if (eq? #\* (read-char)) ((iota)(iota))
        (lambda (c) ((c (lambda (x) (lambda (y) (lambda (z) ((x z)(y z))))))
                     (lambda (x) (lambda (y) x)))))))

;; 以下は demo 用の補助 (Barker の処理系ではない): 文字列から読む。
(define (iota-eval str) (with-input-from-string str read-iota))
