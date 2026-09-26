;;; リストは cons のつながり。car で先頭、cdr で残り。
(defvar *l* (cons 'a (cons 'b (cons 'c nil))))
(print *l*)                ; (A B C)
(print (car *l*))          ; A
(print (cdr *l*))          ; (B C)
(print (car (cdr *l*)))    ; B

;; 1960 年論文の ff: 式の中の最初の原子を返す
(defun ff (x)
  (cond ((atom x) x)
        (t (ff (car x)))))
(print (ff '((a . b) . c)))  ; A

;; 列の長さも再帰で数える
(defun len (x)
  (cond ((null x) 0)
        (t (+ 1 (len (cdr x))))))
(print (len *l*))          ; 3
(terpri)
