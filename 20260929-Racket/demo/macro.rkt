#lang racket
;; マクロで構文そのものを足す。関数では書けない。
(define-syntax-rule (unless test body ...)
  (if test (void) (begin body ...)))

(unless (> 1 2) (displayln "1 は 2 より大きくない"))

;; while が無い言語に while を足す。
(define-syntax-rule (while test body ...)
  (let loop () (when test body ... (loop))))

(define i 0)
(while (< i 3)
  (printf "i = ~a\n" i)
  (set! i (add1 i)))
