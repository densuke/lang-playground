;; Proper tail calls: a recursive call in tail position does not pile up
;; on the stack, so recursion can be used as a loop.
(define (count-up i n)
  (if (= i n)
      i
      (count-up (+ i 1) n)))   ; tail call

(display (count-up 0 10000000))
(newline)

;; The same idea with a named let, the usual way to write a loop.
(define (sum-to n)
  (let loop ((i 1) (acc 0))
    (if (> i n)
        acc
        (loop (+ i 1) (+ acc i)))))

(display (sum-to 10000000))
(newline)
