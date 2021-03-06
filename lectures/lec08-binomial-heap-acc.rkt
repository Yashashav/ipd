;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname lec07-binomial-heap-acc) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; ADT:
;;  empty-heap : Abstract-Heap
;;  is-empty? : Abstract-Heap -> boolean
;;  insert : Abstract-Heap Number -> Abstract-Heap
;;  find-min : Abstract-Heap -> Number
;;     pre: not is-empty?
;;  remove-min : Abstract-Heap -> Abstract-Heap
;;     pre: not is-empty?
;;  meld : Abstract-Heap Abstract-Heap -> Abstract-Heap

(define (insert-nums nums)
  (cond
    [(empty? nums) empty-heap]
    [else (insert (insert-nums (rest nums)) (first nums))]))

(define (remove-mins h)
  (cond
    [(empty-heap? h) '()]
    [else (cons (find-min h)
                (remove-mins (remove-min h)))]))

(check-expect (remove-mins (insert-nums (list 0))) (list 0))
(check-expect (remove-mins (insert-nums (list 0 1))) (list 0 1))
(check-expect (remove-mins (insert-nums (list 1 0))) (list 0 1))
(check-expect (remove-mins (insert-nums (list 0 0))) (list 0 0))
(check-expect (remove-mins (insert-nums (list 1 0 2))) (list 0 1 2))
(check-expect (remove-mins (insert-nums (list 0 1 2))) (list 0 1 2))
(check-expect (remove-mins (insert-nums (list 1 2 0))) (list 0 1 2))
(check-expect (remove-mins (insert-nums (list 0 2 1))) (list 0 1 2))
(check-expect (remove-mins (insert-nums (list 2 1 0))) (list 0 1 2))
(check-expect (remove-mins (insert-nums (list 2 0 1))) (list 0 1 2))


(check-expect (remove-mins (meld (insert-nums (list 0 1 2))
                                 (insert-nums (list 2 1 0))))
              (list 0 0 1 1 2 2))

(check-expect (remove-mins (meld (insert-nums (list 0 1))
                                 (insert-nums (list 2 3))))
              (list 0 1 2 3))

(define zero-thru-sixteen (build-list 17 identity))
(check-expect (remove-mins (insert-nums zero-thru-sixteen))
              zero-thru-sixteen)
(check-expect (remove-mins (insert-nums (reverse zero-thru-sixteen)))
              zero-thru-sixteen)


;; A Binomial-Heap is a [Binomial-Heap-Ranked 0]

;; A [Binomial-Heap-Ranked n] is either:
;; - (cons [Or #false [Binomial-Tree-Ranked n]]
;;         [Binomial-Heap-Ranked (add1 n)])
;; - '()
;; INVARIANT: the last element of the list is not #false

;; A [Binomial-Tree-Ranked n] is
;;   (make-node Number [Binomial-Tree-List n])
;; INVARIANT: the number is smaller than any of
;;            the numbers in the rest of the tree

;; A [Binomial-Tree-List 0] is '()
;; A [Binomial-Tree-List (add1 n)] is
;;   (cons [Binomial-Tree-Ranked n]
;;         [Binomial-Tree-List n])

(define-struct node (value children))

;; find-min : Binomial-Heap -> [Or Number #f]
(define (find-min b)
  (cond
    [(empty? b) #f]
    [else
     (cond
       [(false? (first b)) (find-min (rest b))]
       [else
        (pick-smaller (node-value (first b))
                      (find-min (rest b)))])]))

;; pick-smaller : Number [Or Number #f] -> Number
(define (pick-smaller n1 n2/f)
  (cond
    [(number? n2/f) (min n1 n2/f)]
    [else n1]))

(define empty-heap '())
(define (empty-heap? b) (empty? b))

;; insert : Binomial-Heap Number -> Binomial-Heap
(define (insert b n)
  (add (list (make-node n '())) b))

;; remove-min : [Binomial-Heap-Ranked n] -> [Binomial-Heap-Ranked m]
;; n = m, or n-1 = m
(define (remove-min b)
  (local [(define small-root (find-min b))
          (define heap-without-small-root
            (remove-tree-with-root b small-root))
          (define node-with-small-root
            (find-tree-with-root b small-root))]
    (add heap-without-small-root
         (reverse (node-children node-with-small-root)))))

;; remove-tree-with-root : [Binomial-Tree-List n] Number -> [Binomial-Tree-List n]
(define (remove-tree-with-root b v)
  (cond
    [(empty? b) (error 'ack)]
    [else
     (cond
       [(false? (first b)) (cons #f (remove-tree-with-root (rest b) v))]
       [(= (node-value (first b)) v)
        (cond
          [(empty? (rest b)) '()]
          [else (cons #f (rest b))])]
       [else
        (cons (first b) (remove-tree-with-root (rest b) v))])]))

;; find-tree-with-root : [Binomial-Tree-List n] Integer -> [Binomial-Tree m]
;;  n >= m
(define (find-tree-with-root b v)
  (cond
    [(empty? b) (error 'ack)]
    [else
     (cond
       [(false? (first b)) (find-tree-with-root (rest b) v)]
       [(= (node-value (first b)) v)
        (first b)]
       [else
        (find-tree-with-root (rest b) v)])]))


;; meld : Binomial-Heap Binomial-Heap -> Binomial-Heap
(define (meld h1 h2) (add h1 h2))

;; add : [Binomial-Heap-Ranked n] [Binomial-Heap-Ranked n] -> [Binomial-Heap-Ranked n]
(define (add h1 h2) (add/accum h1 h2 #false))

;; add/accum : [Binomial-Heap-Ranked n]
;;             [Binomial-Heap-Ranked n]
;;             [Or #false [Binomial-Tree-Ranked n]]
;;          -> [Binomial-Heap-Ranked n]
(define (add/accum h1 h2 c-in)
  (cond
    [(and (empty? h1) (empty? h2))
     (cond
       [(false? c-in) '()]
       [else (list c-in)])]
    [(and (empty? h1) (cons? h2))
     (cond
       [(false? c-in) h2]
       [else (add-one c-in h2)])]
    [(and (cons? h1) (empty? h2))
     (cond
       [(false? c-in) h1]
       [else (add-one c-in h1)])]
    [(and (cons? h1) (cons? h2))
     (cond
       [(3-of-them? c-in (first h1) (first h2))
        (cons c-in (add/accum (rest h1) (rest h2) (join (first h1) (first h2))))]
       [(2-of-them? c-in (first h1) (first h2))
        (cons #false (add/accum (rest h1) (rest h2) (join/f (join/f c-in (first h1)) (first h2))))]
       [(1-of-them? c-in (first h1) (first h2))
        (cons (join/f (join/f c-in (first h1)) (first h2))
              (add/accum (rest h1) (rest h2) #false))]
       [else
        (cons #false (add/accum (rest h1) (rest h2) #false))])]))

;; 3-of-them? : [Or #false [Binomial-Tree-Ranked n]]
;;              [Or #false [Binomial-Tree-Ranked n]]
;;              [Or #false [Binomial-Tree-Ranked n]]
;;          --> Boolean
(define (3-of-them? t1 t2 t3)
  (and (node? t1) (node? t2) (node? t3)))

;; 2-of-them? : [Or #false [Binomial-Tree-Ranked n]]
;;              [Or #false [Binomial-Tree-Ranked n]]
;;              [Or #false [Binomial-Tree-Ranked n]]
;;          --> Boolean
(check-expect (2-of-them? #false #false #false) #false)
(check-expect (2-of-them? #false #false (make-node 0 '())) #false)
(check-expect (2-of-them? #false (make-node 0 '()) #false) #false)
(check-expect (2-of-them? (make-node 0 '()) #false #false) #false)
(check-expect (2-of-them? (make-node 0 '()) (make-node 0 '()) (make-node 0 '())) #false)
(define (2-of-them? t1 t2 t3)
  (or (and (false? t1) (node? t2) (node? t3))
      (and (node? t1) (false? t2) (node? t3))
      (and (node? t1) (node? t2) (false? t3))))

;; 1-of-them? : [Or #false [Binomial-Tree-Ranked n]]
;;              [Or #false [Binomial-Tree-Ranked n]]
;;              [Or #false [Binomial-Tree-Ranked n]]
;;          --> Boolean
(check-expect (1-of-them? #false #false #false) #false)
(check-expect (1-of-them? #false #false (make-node 0 '())) #true)
(check-expect (1-of-them? #false (make-node 0 '()) #false) #true)
(check-expect (1-of-them? (make-node 0 '()) #false #false) #true)
(check-expect (1-of-them? (make-node 0 '()) (make-node 0 '()) (make-node 0 '())) #false)
(define (1-of-them? t1 t2 t3)
  (or (and (node? t1) (false? t2) (false? t3))
      (and (false? t1) (node? t2) (false? t3))
      (and (false? t1) (false? t2) (node? t3))))


;; add-one : [Binomial-Tree-Ranked n] [Binomial-Heap-Ranked n] -> [Binomial-Heap-Ranked n]
(define (add-one t h)
  (cond
    [(empty? h) (list t)]
    [else
     (cond
       [(false? (first h))
        (cons t (rest h))]
       [else
        (cons #false (add-one (join (first h) t)
                              (rest h)))])]))

;; join/f : [Or #false [Binomial-Tree-Ranked n]]
;;          [Or #false [Binomial-Tree-Ranked n]]
;;       -> [Or #false [Binomial-Tree-Ranked n] [Binomial-Tree-Ranked (add1 n)]]
(define (join/f t1 t2)
  (cond
    [(false? t1) t2]
    [(false? t2) t1]
    [else (join t1 t2)]))

;; join : [Binomial-Tree-Ranked n] [Binomial-Tree-Ranked n] -> [Binomial-Tree-Ranked (add1 n)]
(define (join t1 t2)
  (cond
    [(< (node-value t1) (node-value t2))
     (make-node (node-value t1)
                (cons t2 (node-children t1)))]
    [else
     (make-node (node-value t2)
                (cons t1 (node-children t2)))]))
