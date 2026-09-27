;; Everything is in parentheses: the procedure name first, then the arguments.
(display "Hello, World!")
(newline)

(define (cube x) (* x x x))
(display (cube 3))
(newline)

(define (fact n)
  (if (= n 0) 1 (* n (fact (- n 1)))))
(display (fact 5))
(newline)
(display (fact 30))   ; integers grow as large as needed
(newline)
