;returns the kth element, starting from 0
(define (Kth k lis)
  (if (zero? k)
      (car lis)
      (Kth (- k 1) (cdr lis))))

;returns the length of a list
(define (listLength lis k)
  (if (null? lis)
      k
      (listLength (cdr lis) (+ k 1))))

;returns the kth last element, starting from 1
(define (KthLast k lis)
  (let ((n (listLength lis 0)))
    (Kth (- n k) lis)))

;returns the list without the first k elements, starting from 0
(define (firstKRemaining k lis)
  (if (zero? k)
      lis
      (firstKRemaining (- k 1) (cdr lis))))

;returns the first k elements in the list, starting from 1
(define (firstK k lis)
  (if (zero? k) 
      '()
      (cons (car lis) (firstK (- k 1) (cdr lis)))))
 
;returns the list without the last k elements, starting from 0
(define (lastKRemaining k lis)
  (let ((n (listLength lis 0)))
    (firstK (- n k) lis)))

;returns the last k elments in the list, starting from 1
(define (lastK k lis)
  (let ((n (listLength lis 0)))
    (firstKRemaining (- n k) lis)))

;returns the right position, where elem should be placed in lis
(define (comp elem lis m)
  (if (null? lis)
      m
      (if (< elem (car lis));if elem < lis[0] then return m
      m
      (comp elem (cdr lis) (+ m 1)))))

;sort the whole list, which has K elements, param k means k elements unsorted. K-k is the position of the element we need move, starting from 0
(define (sort k lis)
  (
   if (zero? k) lis;is k is zero, lis is sorted
      (if (null? (lastKRemaining k lis));if the first K == k
          (sort (- k 1) lis);we don't need move the first element if K == k
          (sort 
           (- k 1) 
           (let ((n (comp (KthLast k lis) (lastKRemaining k lis) 0))
                (m (listLength lis 0)));let n be the right place where the (K-k)th element should be
            (append (append (append;let's assume the list is (1 3 2) and now we are processing the last element
                             (firstK n lis);returns (1)
                             (list (KthLast k lis)));returns (2)
                            (firstKRemaining n (firstK (- m k) lis)));returns (3)
                    (lastK (- k 1) lis)))))))

;main function
(define (insertion-sort k lis)
  (append 
   (sort k (firstK k lis));sort the first k elements and return the sorted list
   (firstKRemaining k lis)));cons the remaining list
