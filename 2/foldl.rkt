(define (foldl f fol lis)
  (if (null? lis) 
      fol
      (foldl f (f fol (car lis)) (cdr lis))))