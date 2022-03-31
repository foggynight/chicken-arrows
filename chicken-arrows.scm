(import procedural-macros)

(define (reduce proc lst)
  (define (aux lst acc)
    (if (null? lst)
        acc
        (aux (cdr lst) (proc acc (car lst)))))
  (if (null? lst)
      #f
      (aux (cdr lst) (car lst))))

(define (insert-first arg surround)
  (cons (car surround) (cons arg (cdr surround))))

(define (insert-last arg surround)
  (append surround (list arg)))

(define (simple-inserter insert-proc)
  (lambda (acc next)
    (if (pair? next)
        (insert-proc acc next)
        (list next acc))))

;; Insert the first sexp of REST as the first argument of the second sexp of
;; REST, the result into the next etc, before evaluation.
(define-macro (-> . rest)
  (reduce (simple-inserter insert-first) rest))

;; Like -> but inserts as the last argument instead of the first.
(define-macro (->> . rest)
  (reduce (simple-inserter insert-last) rest))
