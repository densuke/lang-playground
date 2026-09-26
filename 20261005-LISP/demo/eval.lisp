;;; コードはデータ。S 式のままリストとして組み立て、eval で実行する。
(defvar *code* (list '+ 2 3 4))
(print *code*)                         ; (+ 2 3 4) … ただのリスト
(print (eval *code*))                  ; 9          … 評価すると計算になる

;; 先頭 (car) を + から * に差し替えるだけで別の計算になる
(print (eval (cons '* (cdr *code*))))  ; 24
(terpri)
