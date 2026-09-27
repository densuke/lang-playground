;; Lexical scope: a procedure remembers the variables around where it was
;; written. Each counter keeps its own private "count".
(define (make-counter)
  (let ((count 0))
    (lambda ()
      (set! count (+ count 1))
      count)))

(define a (make-counter))
(define b (make-counter))

(a) (a)
(display (list 'a (a) 'b (b)))
(newline)
