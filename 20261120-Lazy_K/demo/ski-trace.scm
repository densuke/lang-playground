;; SKI の簡約を 1 手ずつ見せる (最左最外 = 遅延評価の順)。
;; 式は ('S 'K 'I か自由変数のシンボル) と (関数 . 引数) の木。
;; 使い方: guile --no-auto-compile ski-trace.scm [式 ...]  (式を渡すとそれだけ追う)
;; 文字列 "SKK(KI)x" -> 木 (左結合、括弧は積んで対応)
(define (parse* str)
  (let loop ((cs (string->list str)) (st '(none)))
    (cond ((null? cs) (car st))
          ((char=? (car cs) #\() (loop (cdr cs) (cons 'none (cons 'paren st))))
          ((char=? (car cs) #\))
           (loop (cdr cs) (join (car st) (cddr st))))
          (else (loop (cdr cs) (join (string->symbol (string (car cs))) st))))))
(define (join e st)                     ; st の先頭 = 作りかけの式 ('none = 空)
  (cons (if (eq? (car st) 'none) e (cons (car st) e)) (cdr st)))
;; --- 簡約 ---
(define (spine e args)                  ; e を (頭 . 引数列) に分解
  (if (pair? e) (spine (car e) (cons (cdr e) args)) (cons e args)))
(define (build h args) (fold-left cons h args))
(define (fold-left f x l) (if (null? l) x (fold-left f (f x (car l)) (cdr l))))
(define (step e)                        ; 1 手簡約。#f なら正規形
  (let* ((s (spine e '())) (h (car s)) (a (cdr s)))
    (cond ((and (eq? h 'I) (>= (length a) 1))
           (build (car a) (cdr a)))
          ((and (eq? h 'K) (>= (length a) 2))
           (build (car a) (cddr a)))
          ((and (eq? h 'S) (>= (length a) 3))
           (build (cons (car a) (caddr a))
                  (cons (cons (cadr a) (caddr a)) (cdddr a))))
          (else                          ; 頭が簡約できない: 引数を左から試す
           (let loop ((as a) (done '()))
             (cond ((null? as) #f)
                   ((step (car as)) => (lambda (n) (build h (append (reverse done) (cons n (cdr as))))))
                   (else (loop (cdr as) (cons (car as) done)))))))))
(define (show e)                        ; 左結合は括弧を省いて表示
  (cond ((symbol? e) (symbol->string e))
        (else (string-append (show (car e))
                             (if (pair? (cdr e)) (string-append "(" (show (cdr e)) ")") (show (cdr e)))))))
(define (trace str max)
  (display "== ") (display str) (newline)
  (let loop ((e (parse* str)) (n 0))
    (display "  ") (display (show e)) (newline)
    (cond ((= n max) (display "  ... (打ち切り: まだ続く)") (newline))
          ((step e) => (lambda (next) (loop next (+ n 1))))
          (else (display "  (正規形)") (newline)))))
(define args (cdr (command-line)))      ; 引数があればその式を追う。無ければ下の 4 つ
(if (pair? args)
    (for-each (lambda (str) (trace str 6)) args)
    (begin
      (trace "SKKx" 10)                 ; SKK は恒等関数 I と同じ働き
      (trace "S(KS)Kxyz" 10)            ; 合成 B: x(yz)
      (trace "KI(SII(SII))" 10)         ; 遅延評価: 発散する式を引数に渡しても捨てるだけなので止まる
      (trace "SII(SII)" 5)))            ; 自分自身を適用し続ける。止まらない
