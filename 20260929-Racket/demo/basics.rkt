#lang racket
;; Racket の基本。括弧の中は (関数 引数 ...) だけ。
(displayln "Hello, world!")

(define (fib n)
  (if (< n 2) n (+ (fib (- n 1)) (fib (- n 2)))))
(displayln (map fib (range 10)))

;; パターンマッチ。データの形で分岐する。
(define (describe x)
  (match x
    [(list a b) (format "2 要素: ~a ~a" a b)]
    [(? number?) "数"]
    [_ "その他"]))
(displayln (describe '(1 2)))
(displayln (describe 42))
