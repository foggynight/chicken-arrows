(import procedural-macros)

(define (reduce proc lst)
  (define (aux lst acc)
    (if (null? lst)
        acc
        (aux (cdr lst) (proc acc (car lst)))))
  (if (null? lst)
      #f
      (aux (cdr lst) (car lst))))

;; Insert SEXP1 as the first argument of SEXP2 before evaluation.
(define-macro (-> sexp1 sexp2)
  (let ((proc (car sexp2)))
    (cons proc (cons sexp1 (cdr sexp2)))))

;; Like -> but inserts as the last argument instead of the first.
(define-macro (->> sexp1 sexp2)
  (let ((proc (car sexp2)))
    (append sexp2 (list sexp1))))
