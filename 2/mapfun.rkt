(define (mapfun FL L)
  (cond 
    ((null? FL) '())
    ((null? L) '())
    (else (cons ((car FL) (car L)) (mapfun (cdr FL) (cdr L))))))
