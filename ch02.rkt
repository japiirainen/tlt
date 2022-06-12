#lang pie

; 80
(claim Pear U)

(define Pear
  (Pair Nat Nat))

; 82
(check-same Pear (cons 3 5) (cons (add1 2) 5))

; 93
(claim Pear-maker U)

(define Pear-maker
  (-> Nat Nat
      Pear))

(claim elim-Pear
  (-> Pear Pear-maker
      Pear))

(define elim-Pear
  (λ (pear maker)
    (maker (car pear) (cdr pear))))

; 95
(check-same
  (Pair Nat Nat)
  (cons 17 3)
  (elim-Pear
    (cons 3 17)
    (λ (a d)
      (cons d a))))

(claim step-+
  (-> Nat Nat))

(define step-+
  (λ (+n-1) (add1 +n-1)))


(claim +
  (-> Nat Nat
      Nat))

(define +
  (λ (n m)
    (iter-Nat n
      m
      step-+)))

; 100
(claim pearwise+
  (-> Pear Pear
      Pear))

(define pearwise+
  (λ (a b)
    (elim-Pear a
      (λ (a1 a2)
        (elim-Pear b
          (λ (b1 b2)
            (cons
              (+ a1 b1)
              (+ a2 b2))))))))

(check-same
  Pear
  (cons 50 120)
  (pearwise+
    (cons 10 20)
    (cons 40 100)))