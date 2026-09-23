#lang racket/base
;; 括弧を使わない自作言語の読み方。1 行が 1 つの式 (+ と * だけ、* が先)。
(provide (rename-out [my-read-syntax read-syntax]))
(require racket/port racket/string)

(define (parse tokens)            ; 足し算で分けてから掛け算で分ける
  (define (term ts) (cons '* (map string->number (string-split ts "*"))))
  (cons '+ (map term (string-split tokens "+"))))

(define (my-read-syntax src in)
  (define lines
    (for/list ([l (port->lines in)] #:unless (string=? (string-trim l) ""))
      `(displayln ,(parse (string-replace l " " "")))))
  (datum->syntax #f `(module hello mylang/main ,@lines)))
