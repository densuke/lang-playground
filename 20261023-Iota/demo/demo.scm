;; Iota は入出力を持たない。式の「結果」は関数 (クロージャ) なので、
;; 記号や数に適用して中身を覗く。
(load "iota.scm")
(load "jot.scm")

(define (show label val) (display label) (display " => ") (write val) (newline))

;; --- 1. i と *ii (Barker のページの手計算と同じ)
(show "(*ii) 'a            [I]" ((iota-eval "*ii") 'a))
(show "((*i*i*ii) 'a) 'b   [K]" (((iota-eval "*i*i*ii") 'a) 'b))
;; S a b c = (a c)(b c)
(define a (lambda (x) (lambda (y) (list 'a x y))))
(define b (lambda (x) (list 'b x)))
(show "S a b 'c            [S]" ((((iota-eval "*i*i*i*ii") a) b) 'c))

;; --- 2. 組合せ論理 (S K I と適用) から Iota への翻訳器 (Barker の表そのまま)
(define (cl->iota e)
  (cond ((eq? e 'I) "*ii")
        ((eq? e 'K) "*i*i*ii")
        ((eq? e 'S) "*i*i*i*ii")
        (else (string-append "*" (cl->iota (car e)) (cl->iota (cadr e))))))

;; Church 数: 0 = K I, succ = S(S(KS)K), mul = S(KS)K
(define zero '(K I))
(define succ '(S ((S (K S)) K)))
(define mul '((S (K S)) K))
(define (church n) (if (= n 0) zero (list succ (church (- n 1)))))
(define (decode f) ((f (lambda (x) (+ x 1))) 0))

(define three (iota-eval (cl->iota (church 3))))
(show "Church 3 を Iota にして復号" (decode three))
(show "Iota の式の長さ (文字数)" (string-length (cl->iota (church 3))))
(show "2 * 3 を Iota で計算" (decode (iota-eval (cl->iota (list (list mul (church 2)) (church 3))))))

;; --- 3. 兄弟 Jot: K = 11100, S = 11111000
(show "Jot 11100 (K)" (((jot-eval "11100") 'a) 'b))
(show "Jot 11111000 (S) a b c" ((((jot-eval "11111000") a) b) 'c))
