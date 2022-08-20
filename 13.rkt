#lang pie

(claim +
  (→ Nat Nat
    Nat))

(define +
  (λ (n m)
    (iter-Nat n
      m
      (λ (+n-1)
        (add1 +n-1)))))

(claim double
  (→ Nat
    Nat))

(define double
  (λ (n)
    (iter-Nat n
      0
      (+ 2))))

(claim Even
  (→ Nat
      U))

(define Even
  (λ (n)
    (Σ ((half Nat))
      (= Nat n (double half)))))

(claim Odd
  (→ Nat
      U))

(define Odd
  (λ (n)
    (Σ ((haf Nat))
      (= Nat n (add1 (double haf))))))

(claim add1-even->odd
  (Π ((n Nat))
    (→ (Even n)
        (Odd (add1 n)))))

(define add1-even->odd
  (lambda(n e_n)
    (cons (car e_n)
      (cong (cdr e_n) (+ 1)))))

(claim add1-odd->even
  (Π ((n Nat))
    (→ (Odd n)
        (Even (add1 n)))))

(define add1-odd->even
  (λ (n e_n)
    (cons (add1 (car e_n))
      (cong (cdr e_n) (+ 1)))))

(claim zero-is-even
  (Even 0))

(define zero-is-even
  (cons 0
    (same 0)))

(claim mot-even-or-odd
  (→ Nat
      U))

(define mot-even-or-odd
  (λ (k)
    (Either (Even k) (Odd k))))

; 19
(claim step-even-or-odd
  (Π ((n-1 Nat))
    (→ (mot-even-or-odd n-1)
        (mot-even-or-odd (add1 n-1)))))

; 30
(define step-even-or-odd
  (λ (n-1)
    (λ (even-or-odd_n-1)
      (ind-Either even-or-odd_n-1
        (λ (even-or-odd_n-1)
          (mot-even-or-odd (add1 n-1)))
        (λ (even_n-1)
          (right
            (add1-even->odd n-1 even_n-1)))
        (λ (odd_n-1)
          (left
            (add1-odd->even n-1 odd_n-1)))))))

; 15
(claim even-or-odd
  (Π ((n Nat))
    (Either (Even n)
            (Odd n))))

; 31
(define even-or-odd
  (λ (n)
    (ind-Nat n
      mot-even-or-odd
      (left zero-is-even)
      step-even-or-odd)))
