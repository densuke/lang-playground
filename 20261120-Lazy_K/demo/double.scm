;; ラムダ式 (Scheme 記法) から Lazy K への変換を、作者の lazier.scm で見せる。
;; 1) 作者 README の例 (cdr) を 4 つの記法で出す
;; 2) 入力の各文字を 2 回ずつ出すプログラム dup を作り、Unlambda 記法で書き出す
(load "/opt/lazyk/lazier.scm")
(load "/opt/lazyk/prelude.scm")

(lazy-def '(myprog input) '(cdr (cdr input)))   ; 先頭 2 バイトを捨てる
(for-each (lambda (name printer)
            (display name) (display ": ") (printer (laze 'myprog)))
          '("CC     " "Unlambda" "Iota   " "Jot    ")
          (list print-as-cc print-as-unlambda print-as-iota print-as-jot))

(lazy-def 'dup
 '((lambda (x) (x x))
   (lambda (self lst)
     (cons (car lst) (cons (car lst) (self self (cdr lst)))))))

(with-output-to-file "/tmp/dup.lazy"
  (lambda () (print-as-unlambda (laze 'dup))))
(newline)
(display "dup.lazy へ書き出した (") (display (- (stat:size (stat "/tmp/dup.lazy")) 1))
(display " 記号)") (newline)
