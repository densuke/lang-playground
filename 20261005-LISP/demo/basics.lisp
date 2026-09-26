;;; Hello World とフィボナッチ。ループ構文を使わず cond と再帰だけで書く。
(print "Hello, world!")

(defun fib (n)
  (cond ((< n 2) n)
        (t (+ (fib (- n 1)) (fib (- n 2))))))

(defun fibs (i n)                 ; i から n-1 までの fib をリストにする
  (cond ((= i n) nil)
        (t (cons (fib i) (fibs (+ i 1) n)))))

(print (fibs 0 10))
(terpri)
