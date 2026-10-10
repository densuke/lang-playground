;; Jot の参照実装。Chris Barker 同ページより原文のまま (標準入力から読む)。
;; 出典: https://web.archive.org/web/20201112014512/http://www.nyu.edu/projects/barker/Iota/
(define (read-jot)
  (let jot ((v (lambda (x) x)))
    (cond ((eof-object? (peek-char)) v)
      ((eq? #\1 (read-char)) (jot (lambda (f) (lambda (a) (v (f a))))))
      (else (jot ((v (lambda (x) (lambda (y) (lambda (z) ((x z)(y z))))))
            (lambda (x) (lambda (y) x))))))))
(define (jot-eval str) (with-input-from-string str read-jot))
