(define (comparatorFuns N)
  (if (zero? N)
      '()
      (append 
       (comparatorFuns (- N 1)) 
       (list (lambda x (if (> (car x) N) #t #f))))))