(define (filter pred L)
  (if (null? L)
      '();if L is null, return end-of-list
      (if (pred (car L))
      (cons (car L) (filter pred (cdr L)))
      (filter pred (cdr L)))))