#lang pie

(claim +
  (-> Nat Nat
      Nat))

(define +
  (λ (n m)
    (iter-Nat n
      m
      (λ (+n-1)
        (add1 +n-1)))))

; 5
(claim incr
  (-> Nat
      Nat))

(define incr
  (λ (x)
    (iter-Nat x
      1
      (+ 1))))

(check-same Nat (incr 68) 69)

(claim incr-2=3
  (= Nat (incr 2) 3))

(define incr-2=3
  ; (same (incr 2))
  (same 3)
  )

(claim +1=add1
  (Pi ((n Nat))
      (= Nat (add1 n) (+ 1 n))))

(define +1=add1
  (λ (n)
    (same (add1 n))))

(claim incr=add1
  (Pi ((n Nat))
      (= Nat (incr n) (add1 n))))

(claim base-incr=add1
  (= Nat (incr zero) (add1 zero)))

(define base-incr=add1
  (same (add1 zero)))

(claim mot-incr=add1
  (-> Nat U))

(define mot-incr=add1
  (λ (n)
    (= Nat (incr n) (add1 n))))

(claim step-incr=add1
  (Pi ((n-1 Nat))
      (-> (= Nat
             (incr n-1)
             (add1 n-1))
          (= Nat
             (add1 (incr n-1))
             (add1 (add1 n-1))))))

(define step-incr=add1
  (λ (n-1)
    (λ (incr=add1_n-1)
      (cong incr=add1_n-1 (+ 1)))))

(define incr=add1
  (λ (n)
    (ind-Nat n
      mot-incr=add1
      base-incr=add1
      step-incr=add1)))

(check-same
  (= Nat 69 69)
  (incr=add1 68)
  (the (= Nat 69 69) (same 69)))

; 90
(claim sandwitch
  (-> Atom
      Atom))

(define sandwitch
  (λ (_)
    'delicious))

(check-same Atom (sandwitch 'ham) (sandwitch 'pepperoni))
